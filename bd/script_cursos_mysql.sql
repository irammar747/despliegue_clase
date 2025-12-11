-- 1. Creamos la BD forzando la codificación UTF-8 Multibyte
DROP DATABASE IF EXISTS academia;
CREATE DATABASE IF NOT EXISTS academia CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE academia;

SET NAMES 'utf8mb4'; 
SET CHARACTER SET utf8mb4;

-- ==========================================================
-- GESTIÓN DE USUARIOS 
-- ==========================================================
-- Creamos el usuario 'usuario' si no existe
CREATE USER IF NOT EXISTS 'usuario'@'%' IDENTIFIED BY 'oretania';

-- Le damos TODOS los permisos sobre esta base de datos
GRANT ALL PRIVILEGES ON academia.* TO 'usuario'@'%';

-- Aplicamos los cambios de permisos inmediatamente
FLUSH PRIVILEGES;

-- 2. Tabla Cursos
CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Esto actúa como serial
    titulo VARCHAR(100) NOT NULL,
    numero_horas INT NOT NULL,
    descripcion TEXT
) ENGINE=InnoDB;

-- 3. Tabla Alumnos
CREATE TABLE alumnos (
    dni VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    direccion VARCHAR(150),
    telefono VARCHAR(15),
    fecha_nacimiento DATE
) ENGINE=InnoDB;

-- 4. Tabla Intermedia (Inscripciones)
CREATE TABLE inscribe (
    id_curso INT,
    dni_alumno VARCHAR(15),
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_curso, dni_alumno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id) ON DELETE CASCADE,
    FOREIGN KEY (dni_alumno) REFERENCES alumnos(dni) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==========================================
-- INSERCIÓN DE DATOS (Con tildes y Ñ)
-- ==========================================

-- Insertar 5 Cursos
INSERT INTO cursos (titulo, numero_horas, descripcion) VALUES
('Desarrollo Web Full Stack', 600, 'Aprende HTML, CSS, PHP y JavaScript desde cero.'),
('Diseño Gráfico Digital', 300, 'Curso intensivo de Photoshop e Illustrator.'),
('Bases de Datos Avanzadas', 150, 'Optimización de consultas SQL y NoSQL.'),
('Programación en Python', 200, 'Ciencia de datos e Inteligencia Artificial.'),
('Inglés Técnico para TI', 100, 'Vocabulario específico para entornos tecnológicos.');

-- Insertar 20 Alumnos (Nombres con caracteres especiales para probar)
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

-- Insertar Matrículas (Tabla intermedia)
-- Matricular varios alumnos en el Curso 1 (Desarrollo Web)
INSERT INTO inscribe (id_curso, dni_alumno) VALUES
(1, '11111111A'), (1, '22222222B'), (1, '33333333C'), (1, '44444444D'), (1, '55555555E');

-- Matricular en Curso 2 (Diseño)
INSERT INTO inscribe (id_curso, dni_alumno) VALUES
(2, '66666666F'), (2, '77777777G'), (2, '88888888H'), (2, '11111111A'); -- Iñigo repite curso

-- Matricular en Curso 3 (BD)
INSERT INTO inscribe (id_curso, dni_alumno) VALUES
(3, '99999999I'), (3, '12312312J'), (3, '23423423K'), (3, '33333333C'); -- José repite curso

-- Matricular en Curso 4 (Python)
INSERT INTO inscribe (id_curso, dni_alumno) VALUES
(4, '34534534L'), (4, '45645645M'), (4, '56756756N'), (4, '67867867P'), (4, '78978978Q');

-- Matricular en Curso 5 (Inglés)
INSERT INTO inscribe (id_curso, dni_alumno) VALUES
(5, '89089089R'), (5, '90190190S'), (5, '01201201T'), (5, '12345678V'), (5, '22222222B'); -- María repite curso