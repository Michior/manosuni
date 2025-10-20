SET search_path TO manosuni, public;


-- USERS (login/registro)

INSERT INTO users (name, email, password) VALUES
('Mauricio Ramírez', 'mauricio@uni.edu', 'devpass'),
('Javier Avilés',    'javier@uni.edu',   'devpass'),
('Nahomi Ortiz',     'nahomi@uni.edu',   'devpass')
ON CONFLICT (email) DO UPDATE SET name = EXCLUDED.name;


-- Estudiantes

INSERT INTO students (full_name, email, university, major, semester, birthdate) VALUES
('Mauricio Ramírez', 'mauricio@uni.edu', 'UES', 'Ingeniería de Sistemas', 5, '2003-06-15'),
('Javier Avilés',    'javier@uni.edu',   'UCA', 'Administración de Empresas', 7, '2001-09-02'),
('Nahomi Ortiz',     'nahomi@uni.edu',   'UCA', 'Diseño Gráfico', 8, '2002-02-22')
ON CONFLICT (email) DO NOTHING;


-- ONGs reales 

INSERT INTO ngos (name, reg_number, description, website, contact_email, phone, address) VALUES
('TECHO El Salvador', 'ONG-00123', 'Voluntariado juvenil para construir viviendas de emergencia en comunidades vulnerables.', 'https://www.techo.org/el-salvador', 'info@techo.org', '2250-1234', 'San Salvador'),
('Glasswing International', 'ONG-00456', 'Programas de voluntariado y mentoría educativa para jóvenes.', 'https://glasswing.org', 'contact@glasswing.org', '2210-5678', 'Col. San Benito, San Salvador')
ON CONFLICT DO NOTHING;


-- Actividades

INSERT INTO activities (ngo_id, title, description, category, modality, start_datetime, end_datetime, hours_value, capacity, status)
VALUES
(1, 'Construcción de Viviendas', 'Voluntariado de fin de semana para construir casas en comunidades rurales.', 'Vivienda', 'onsite',  NOW() + INTERVAL '2 day', NOW() + INTERVAL '2 day 7 hour', 7, 30, 'open'),
(2, 'Programa de Mentoría Escolar', 'Apoyo escolar en matemáticas y lectura para estudiantes de centros públicos.', 'Educación', 'onsite', NOW() + INTERVAL '5 day', NOW() + INTERVAL '5 day 3 hour 30 minute', 3.5, 25, 'open')
ON CONFLICT DO NOTHING;


-- Inscripciones

INSERT INTO enrollments (activity_id, student_id, status) VALUES
(1, 1, 'enrolled'),
(2, 2, 'enrolled')
ON CONFLICT DO NOTHING;


-- Ventanas QR

INSERT INTO qr_windows (activity_id, token, kind, opened_at, closes_at) VALUES
(1, 'CHKIN-TEC001',  'checkin', NOW(),               NOW() + INTERVAL '2 hour'),
(1, 'CHKOUT-TEC001', 'checkout', NOW() + INTERVAL '6 hour', NOW() + INTERVAL '7 hour'),
(2, 'CHKIN-GLW001',  'checkin', NOW(),               NOW() + INTERVAL '2 hour')
ON CONFLICT DO NOTHING;


-- Horas sociales

INSERT INTO hours_ledger (enrollment_id, computed_hours, status) VALUES
(1, 7.0, 'approved'),
(2, 3.5, 'pending')
ON CONFLICT DO NOTHING;


-- Logros

INSERT INTO achievements (student_id, name) VALUES
(1, 'Primer Proyecto de Vivienda Completado'),
(2, 'Mentor Educativo Destacado')
ON CONFLICT DO NOTHING;


-- Certificados 

INSERT INTO certificates (student_id, title, issued_by, file_url) VALUES
(1, 'Certificado de Voluntariado TECHO',  'TECHO El Salvador',        'https://www.techo.org/el-salvador'),
(2, 'Certificado de Mentoría Glasswing',  'Glasswing International',  'https://glasswing.org')
ON CONFLICT DO NOTHING;
