CREATE SCHEMA IF NOT EXISTS manosuni;
SET search_path TO manosuni, public;

CREATE EXTENSION IF NOT EXISTS citext;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname='activity_modality') THEN
    CREATE TYPE activity_modality AS ENUM ('onsite','remote','hybrid');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname='activity_status') THEN
    CREATE TYPE activity_status AS ENUM ('draft','open','closed','archived');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname='enrollment_status') THEN
    CREATE TYPE enrollment_status AS ENUM ('enrolled','cancelled','completed');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname='qr_kind') THEN
    CREATE TYPE qr_kind AS ENUM ('checkin','checkout');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname='hours_status') THEN
    CREATE TYPE hours_status AS ENUM ('pending','approved','rejected');
  END IF;
END$$;


-- USERS (para login/registro del front)

CREATE TABLE IF NOT EXISTS users (
  id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  email       CITEXT NOT NULL UNIQUE,
  password    VARCHAR(255) NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION trg_set_updated_at()
RETURNS trigger AS $$
BEGIN
  NEW.updated_at := CURRENT_TIMESTAMP;
  RETURN NEW;
END$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS users_set_updated_at ON users;
CREATE TRIGGER users_set_updated_at
BEFORE UPDATE ON users
FOR EACH ROW EXECUTE FUNCTION trg_set_updated_at();

CREATE INDEX IF NOT EXISTS idx_users_name ON users(name);

-- Core del proyecto (estudiantes/ONGs/actividades)

CREATE TABLE IF NOT EXISTS students (
  student_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  full_name      TEXT NOT NULL,
  email          CITEXT UNIQUE,
  phone          TEXT,
  university     TEXT,
  major          TEXT,
  semester       INT,
  birthdate      DATE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS ngos (
  ngo_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name           TEXT NOT NULL,
  reg_number     TEXT,
  description    TEXT,
  website        TEXT,
  contact_email  CITEXT,
  phone          TEXT,
  address        TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS ngo_admins (
  admin_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  ngo_id         BIGINT NOT NULL REFERENCES ngos(ngo_id) ON DELETE CASCADE,
  full_name      TEXT NOT NULL,
  email          CITEXT NOT NULL,
  role           TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (ngo_id, email)
);

CREATE TABLE IF NOT EXISTS locations (
  location_id    BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  country        TEXT,
  state          TEXT,
  city           TEXT,
  address_line   TEXT,
  latitude       DOUBLE PRECISION,
  longitude      DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS activities (
  activity_id    BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  ngo_id         BIGINT NOT NULL REFERENCES ngos(ngo_id) ON DELETE CASCADE,
  title          TEXT NOT NULL,
  description    TEXT,
  category       TEXT,
  modality       activity_modality NOT NULL DEFAULT 'onsite',
  start_datetime TIMESTAMPTZ NOT NULL,
  end_datetime   TIMESTAMPTZ,
  hours_value    NUMERIC(6,2) DEFAULT 0,
  capacity       INT,
  location_id    BIGINT REFERENCES locations(location_id) ON DELETE SET NULL,
  status         activity_status NOT NULL DEFAULT 'open',
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS enrollments (
  enrollment_id  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  activity_id    BIGINT NOT NULL REFERENCES activities(activity_id) ON DELETE CASCADE,
  student_id     BIGINT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  status         enrollment_status NOT NULL DEFAULT 'enrolled',
  enrolled_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (activity_id, student_id)
);

CREATE TABLE IF NOT EXISTS qr_windows (
  qr_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  activity_id    BIGINT NOT NULL REFERENCES activities(activity_id) ON DELETE CASCADE,
  token          TEXT NOT NULL UNIQUE,
  opened_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  closes_at      TIMESTAMPTZ,
  kind           qr_kind NOT NULL DEFAULT 'checkin'
);

CREATE TABLE IF NOT EXISTS attendance_logs (
  attendance_id  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  enrollment_id  BIGINT NOT NULL REFERENCES enrollments(enrollment_id) ON DELETE CASCADE,
  qr_id          BIGINT NOT NULL REFERENCES qr_windows(qr_id) ON DELETE CASCADE,
  scanned_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (enrollment_id, qr_id)
);

CREATE TABLE IF NOT EXISTS hours_ledger (
  hours_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  enrollment_id  BIGINT NOT NULL REFERENCES enrollments(enrollment_id) ON DELETE CASCADE,
  computed_hours NUMERIC(6,2) NOT NULL DEFAULT 0,
  status         hours_status NOT NULL DEFAULT 'pending',
  reviewer_id    BIGINT REFERENCES ngo_admins(admin_id) ON DELETE SET NULL,
  reviewed_at    TIMESTAMPTZ,
  notes          TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS achievements (
  achievement_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  student_id     BIGINT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  name           TEXT NOT NULL,
  earned_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS certificates (
  certificate_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  student_id     BIGINT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  title          TEXT NOT NULL,
  issued_by      TEXT,
  file_url       TEXT,
  issued_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


-- Índices

CREATE INDEX IF NOT EXISTS idx_students_email ON students(email);
CREATE INDEX IF NOT EXISTS idx_ngos_name ON ngos(name);
CREATE INDEX IF NOT EXISTS idx_activities_status ON activities(status);
CREATE INDEX IF NOT EXISTS idx_enrollments_student ON enrollments(student_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_activity ON enrollments(activity_id);
CREATE INDEX IF NOT EXISTS idx_qr_windows_activity ON qr_windows(activity_id);


-- Vistas

CREATE OR REPLACE VIEW v_activity_roster AS
SELECT a.activity_id, a.title, s.student_id, s.full_name, e.status AS enrollment_status
FROM activities a
JOIN enrollments e ON e.activity_id = a.activity_id
JOIN students s ON s.student_id = e.student_id;

CREATE OR REPLACE VIEW v_student_hours AS
SELECT s.student_id, s.full_name,
       COALESCE(SUM(CASE WHEN h.status='approved' THEN h.computed_hours END),0) AS approved_hours,
       COALESCE(SUM(CASE WHEN h.status='pending' THEN h.computed_hours END),0) AS pending_hours
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.student_id
LEFT JOIN hours_ledger h ON h.enrollment_id = e.enrollment_id
GROUP BY s.student_id, s.full_name;
