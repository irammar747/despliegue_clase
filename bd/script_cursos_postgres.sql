-- 1. Creación de la base de datos 
DROP DATABASE IF EXISTS academia;
CREATE DATABASE academia WITH ENCODING = 'UTF8';

\c academia

-- ==========================================================
-- GESTIÓN DE USUARIOS 
-- ==========================================================
-- 1. Borramos el usuario 'alumno' si ya existía para evitar errores
DROP ROLE IF EXISTS usuario;

-- 2. Creamos el usuario con contraseña
CREATE ROLE usuario WITH LOGIN PASSWORD 'oretania';

-- 3. Le damos permisos sobre la base de datos
GRANT CONNECT ON DATABASE academia TO usuario;

-- 4. VITAL EN POSTGRES: Permisos sobre el esquema "public"
-- Si no haces esto, el usuario puede entrar pero no puede ver las tablas
GRANT USAGE ON SCHEMA public TO usuario;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO usuario;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO usuario;

-- 5. Asegurar que las tablas futuras también sean accesibles (Default Privileges)
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO usuario;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO usuario;

-- 2. Tabla Cursos
CREATE TABLE cursos (
    id SERIAL PRIMARY KEY, 
    titulo VARCHAR(100) NOT NULL,
    numero_horas INT NOT NULL,
    descripcion TEXT
);

-- 3. Tabla Alumnos
CREATE TABLE alumnos (
    dni VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    direccion VARCHAR(150),
    telefono VARCHAR(15),
    fecha_nacimiento DATE
);

-- 4. Tabla Intermedia (Inscripciones)
CREATE TABLE inscribe (
    id_curso INT,
    dni_alumno VARCHAR(15),
    fecha_inscripcion DATE DEFAULT CURRENT_DATE, 
    PRIMARY KEY (id_curso, dni_alumno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id) ON DELETE CASCADE,
    FOREIGN KEY (dni_alumno) REFERENCES alumnos(dni) ON DELETE CASCADE
);

-- ==========================================
-- INSERCIÓN DE DATOS (Mismos datos)
-- ==========================================

-- Insertar 5 Cursos
INSERT INTO cursos (titulo, numero_horas, descripcion) VALUES
('Desarrollo Web Full Stack', 600, 'Aprende HTML, CSS, PHP y JavaScript desde cero.'),
('Diseño Gráfico Digital', 300, 'Curso intensivo de Photoshop e Illustrator.'),
('Bases de Datos Avanzadas', 150, 'Optimización de consultas SQL y NoSQL.'),
('Programación en Python', 200, 'Ciencia de datos e Inteligencia Artificial.'),
('Inglés Técnico para TI', 100, 'Vocabulario específico para entornos tecnológicos.');

-- Insertar 20 Alumnos
INSERT INTO alumnos (dni, nombre, apellido1, apellido2, direccion, telefono, fecha_nacimiento) VALUES
('11111111A', 'Iñigo', 'Nuñez', 'García', 'C/ La Cigüeña 1', '600111222', '1995-05-15'),
('22222222B', 'María', 'López', 'Sánchez', 'Avda. Constitución 23', '600333444', '1998-11-20'),
('33333333C', 'José', 'Pérez', 'Gómez', 'Plaza España 5', '600555666', '1990-01-10'),
('44444444D', 'Verónica', 'Díaz', 'Muñoz', 'C/ Peñón 8', '600777888', '1992-07-30'),
('55555555E', 'Raúl', 'Ibáñez', 'Fernández', 'C/ Mayor 12', '600999000', '1996-03-25'),
('66666666F', 'Begoña', 'Álvarez', 'Ruíz', 'C/ El Olivo 4', '611222333', '1993-09-12'),
('77777777G', 'Ángel', 'Martínez', 'Castaño', 'Avda. del Río 90', '611444555', '1989-12-05'),
('88888888H', 'Sofía', 'Gutiérrez', 'Ordoñez', 'C/ Luna 7', '611666777', '2000-02-14'),
('99999999I', 'Óscar', 'Domínguez', 'Serrano', 'C/ Sol 3', '611888999', '1997-06-18'),
('12312312J', 'Noelia', 'Vázquez', 'Jiménez', 'Paseo del Prado 2', '622111222', '1999-08-22'),
('23423423K', 'Jesús', 'Hernández', 'Romero', 'C/ Ancha 15', '622333444', '1991-04-04'),
('34534534L', 'Mónica', 'Navarro', 'Torres', 'C/ Estrecha 88', '622555666', '1994-10-10'),
('45645645M', 'Héctor', 'Gil', 'Ramírez', 'C/ Nueva 10', '622777888', '1988-05-30'),
('56756756N', 'Lucía', 'Molina', 'Blanco', 'Avda. Libertad 50', '622999000', '2001-12-01'),
('67867867P', 'Rubén', 'Morales', 'Ortega', 'C/ Falsa 123', '633111222', '1996-02-28'),
('78978978Q', 'Aitana', 'Delgado', 'Castro', 'C/ Real 1', '633333444', '1998-07-07'),
('89089089R', 'Cristian', 'Ortiz', 'Rubio', 'Plaza Mayor 10', '633555666', '1995-11-15'),
('90190190S', 'Elena', 'Marín', 'Sanz', 'C/ Verde 4', '633777888', '1993-03-03'),
('01201201T', 'David', 'Iglesias', 'Nuñez', 'C/ Azul 9', '633999000', '1990-09-09'),
('12345678V', 'Ágata', 'Ríos', 'León', 'Avda. Central 5', '644111222', '1999-01-20');

-- Insertar Matrículas
INSERT INTO inscribe (id_curso, dni_alumno) VALUES
(1, '11111111A'), (1, '22222222B'), (1, '33333333C'), (1, '44444444D'), (1, '55555555E'),
(2, '66666666F'), (2, '77777777G'), (2, '88888888H'), (2, '11111111A'),
(3, '99999999I'), (3, '12312312J'), (3, '23423423K'), (3, '33333333C'),
(4, '34534534L'), (4, '45645645M'), (4, '56756756N'), (4, '67867867P'), (4, '78978978Q'),
(5, '89089089R'), (5, '90190190S'), (5, '01201201T'), (5, '12345678V'), (5, '22222222B');