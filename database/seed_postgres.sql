-- Datos de prueba para ManosUni
SET search_path TO manosuni, public;

-- estudiantes
INSERT INTO students (full_name, email, university, major, semester, birthdate)
VALUES
('Mauricio Ramírez', 'mauricio@uni.edu', 'UES', 'Ingeniería de Sistemas', 5, '2003-06-15'),
('Javier Avilés', 'javier@uni.edu', 'UCA', 'Administración de Empresas', 7, '2001-09-02'),
('Nahomi Ortiz', 'nahomi@uni.edu', 'UCA', 'Diseño Gráfico', 8, '2002-02-22');

-- ongs reales en El Salvador
INSERT INTO ngos (name, reg_number, description, website, contact_email, phone, address)
VALUES
('TECHO El Salvador', 'ONG-00123', 'Voluntariado juvenil para construir viviendas de emergencia en comunidades vulnerables.', 'https://www.techo.org/el-salvador', 'info@techo.org', '2250-1234', 'San Salvador, El Salvador'),
('Glasswing International', 'ONG-00456', 'Organiza programas de voluntariado y mentoría educativa para jóvenes.', 'https://www.glasswing.org', 'contact@glasswing.org', '2210-5678', 'Col. San Benito, San Salvador');

-- actividades
INSERT INTO activities (ngo_id, title, description, category, modality, start_datetime, end_datetime, hours_value, capacity, status)
VALUES
(1, 'Construcción de Viviendas', 'Voluntariado de fin de semana para construir casas en comunidades rurales.', 'Vivienda', 'onsite', '2025-11-10 08:00', '2025-11-10 15:00', 7, 30, 'open'),
(2, 'Programa de Mentoría Escolar', 'Apoyo a estudiantes de centros escolares públicos en matemáticas y lectura.', 'Educación', 'onsite', '2025-11-15 09:00', '2025-11-15 12:30', 3.5, 25, 'open');

-- inscripciones
INSERT INTO enrollments (activity_id, student_id, status)
VALUES
(1, 1, 'enrolled'),
(2, 2, 'enrolled');

-- ventanas QR
INSERT INTO qr_windows (activity_id, token, kind, opened_at, closes_at)
VALUES
(1, 'CHKIN-TEC001', 'checkin', NOW(), NOW() + INTERVAL '2 hour'),
(1, 'CHKOUT-TEC001', 'checkout', NOW() + INTERVAL '6 hour', NOW() + INTERVAL '7 hour'),
(2, 'CHKIN-GLW001', 'checkin', NOW(), NOW() + INTERVAL '2 hour');

-- horas sociales
INSERT INTO hours_ledger (enrollment_id, computed_hours, status)
VALUES
(1, 7.0, 'approved'),
(2, 3.5, 'pending');

-- logros
INSERT INTO achievements (student_id, name)
VALUES
(1, 'Primer Proyecto de Vivienda Completado'),
(2, 'Mentor Educativo Destacado');

-- certificados
INSERT INTO certificates (student_id, title, issued_by, file_url)
VALUES
(1, 'Certificado de Voluntariado TECHO', 'TECHO El Salvador', 'https://www.techo.org/el-salvador'),
(2, 'Certificado de Mentoría Glasswing', 'Glasswing International', 'https://glasswing.org');
