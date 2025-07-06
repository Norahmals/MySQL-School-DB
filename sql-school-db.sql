-- Create a new database for the school project
CREATE DATABASE school_db;

-- Select the database to use
USE school_db;

USE school_db;
-- Create a table to store student personal and academic information
CREATE TABLE students (
	student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    student_email VARCHAR(50),
    gender ENUM('M', 'F'),
    student_level INT,
    track ENUM('Science', 'Arts'),
    gpa DECIMAL(5,2)
);

USE school_db;
-- Create a table to store teacher details and contact info
CREATE TABLE teachers (
	teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    office_number VARCHAR(10)
);

USE school_db;
-- Create a table to store subject names and related info
CREATE TABLE subjects (
	subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100)
);

-- Display the list of all tables in the current database
SHOW TABLES;

USE school_db;
-- Insert multiple student records into the students table
INSERT INTO students (first_name, last_name, student_email, gender, student_level, track, gpa)
VALUES
('Norah', 'Alsubaie', 'norah@gmail.com', 'F', 6, 'Science', 100),
('Anwar', 'Alotaibi', 'anwar@gmail.com', 'F', 5, 'Science', 98),
('Lama', 'Ahmad', 'lama@gmail.com', 'F', 4, 'Arts', 97),
('Lulua', 'Salim', 'lulua@gmail.com', 'F', 2, 'Science', 77),
('Amal', 'Omar', 'amal@gmail.com', 'F', 3, 'Arts', 98),
('Sarah', 'Ahmad', 'sarah@gmail.com', 'F', 1, 'Arts', 91),
('Norah', 'Turki', 'norah2@gmail.com', 'F', 4, 'Arts', 88),
('Amjad', 'Alotaibi', 'amjad@gmail.com', 'F', 6, 'Science', 67),
('Lama', 'Majed', 'lama2@gmail.com', 'F', 1, 'Arts', 99),
('Lulua', 'Saad', 'lulua2@gmail.com', 'F', 2, 'Science', 97),
('Alaa', 'Omar', 'alaa@gmail.com', 'F', 1, 'Arts', 60),
('Samar', 'Ahmad', 'samar@gmail.com', 'F', 5, 'Arts', 91),
('Turki', 'Alsubaie', 'turki@gmail.com', 'M', 6, 'Science', 99),
('Aziz', 'Alotaibi', 'aziz@gmail.com', 'M', 5, 'Science', 98),
('Bader', 'Ahmad', 'bader@gmail.com', 'M', 4, 'Arts', 56),
('Abdullah', 'Salim', 'abdullah@gmail.com', 'M', 2, 'Science', 77),
('Ahmad', 'Omar', 'ahmad@gmail.com', 'M', 3, 'Arts', 98),
('Saad', 'Ahmad', 'saad@gmail.com', 'M', 1, 'Arts', 91),
('Nawaf', 'Turki', 'nawaf@gmail.com', 'M', 4, 'Arts', 88),
('Mohammed', 'Alotaibi', 'mohammed@gmail.com', 'M', 6, 'Science', 76),
('Abdulaziz', 'Majed', 'abdulaziz@gmail.com', 'M', 1, 'Arts', 99),
('Sultan', 'Saad', 'sultan@gmail.com', 'M', 2, 'Science', 96),
('Bandar', 'Omar', 'bandar@gmail.com', 'M', 1, 'Arts', 64),
('faisal', 'Ahmad', 'faisal@gmail.com', 'M', 5, 'Arts', 92);

USE school_db;
-- Insert multiple teacher records into the teachers table
INSERT INTO teachers (first_name, last_name, office_number)
VALUES
('Nuha', 'Ahmad', 'B1'),
('Lamar', 'Turki', 'B2'),
('Samar', 'Khaled', 'B3'),
('Turki', 'Khaled', 'B4'),
('Ahmad', 'Hamad', 'B5'),
('Omar', 'Khaled', 'B6'),
('Hamad', 'Turki', 'B7'),
('Faisal', 'Mohammed', 'B8'),
('Bandar', 'Turki', 'B9'),
('Ahmad', 'Mohammed', 'B10');

USE school_db;
-- Insert multiple subject records into the subjects table
INSERT INTO subjects (subject_name)
VALUES
('Math'),
('Arabic'),
('Chemistry'),
('Physics'),
('Biology'),
('Computer');

-- Display all columns and rows from the students table
SELECT * FROM students;

-- Display all columns and rows from the teachers table
SELECT * FROM teachers;

-- Display all columns and rows from the subjects table
SELECT * FROM subjects;

-- Display all students ordered by their first name in ascending order
SELECT * FROM students
ORDER BY first_name ASC;

-- Combine first name and last name into a single column called student_name 
SELECT CONCAT(first_name, ' ', last_name) AS student_name FROM students;

-- Update the email address of the student with ID = 1
UPDATE students
SET student_email = 'norah99@gmail.com'
WHERE student_id = 1;

-- Update the office number of the teacher with ID = 1
UPDATE teachers
SET office_number = 'B11'
WHERE teacher_id = 1;

-- Rename the 'students' table to 'students_data'
RENAME TABLE students TO students_data;

CREATE TABLE top_students AS 
SELECT * FROM students_data
WHERE gpa >= 90;

CREATE TABLE failed_students AS 
SELECT * FROM students_data
WHERE gpa < 60;

SELECT first_name, last_name
FROM students_data
WHERE LENGTH(first_name) = 4;

SELECT
	AVG(gpa) AS average_gpa,
    MAX(gpa) AS highest_gpa,
    MIN(gpa) AS lowest_gpa
FROM students_data;

SELECT first_name, last_name
FROM students_data
WHERE gpa = 100 AND student_level = 6;

ALTER TABLE students_data ADD age INT;

UPDATE students_data
SET age = 16
WHERE student_id = 1;

SELECT * FROM students_data
WHERE student_id = 1 AND age BETWEEN 15 AND 19;

SELECT COUNT(*) AS level_2_count
FROM students_data
WHERE student_level = 2;

SELECT DISTINCT track
FROM students_data;

SELECT UPPER(subject_name) AS upper_subject
FROM subjects;

SELECT
	ROUND(AVG(gpa), 0) AS rounded_avg_gpa,
    FLOOR(AVG(gpa)) AS floored_avg_gpa
FROM students_data;

ALTER TABLE students_data
MODIFY gender ENUM('M', 'F', 'Male', 'Female');

UPDATE students_data
SET gender = REPLACE(gender, 'F', 'Female')
WHERE gender = 'F';

UPDATE students_data
SET gender = REPLACE(gender, 'M', 'Male')
WHERE gender = 'M';

UPDATE students_data
SET gpa = gpa + 5
WHERE gpa < 60;