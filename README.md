## School Database Project (MySQL) 

This project was built as the final implementation of SQL 101, 102, and 103 courses from the Satr platform. It simulates a school system with students, teachers, and subjects. The project covers schema design, data insertion, cleaning, relationships, advanced queries, procedures, views, and indexes using MySQL.

---

## Project Objectives

- Design and build a normalized relational database for a school system.
- Populate tables with realistic records.
- Clean and transform data using SQL statements.
- Analyze the data using aggregate functions and complex queries.
- Create many-to-many relationships using bridge tables.
- Implement stored procedures, views, and indexes.

---

## Database Setup

```
CREATE DATABASE school_db;
USE school_db;
```

---
## Schema Design

The database consists of three main tables:

- `students`: Contains personal and academic data.
- `teachers`: Stores teacher names and office numbers.
- `subjects`: Stores subject names.

All primary keys are set to `AUTO_INCREMENT`. Data types were selected carefully based on context, including VARCHAR for text, INT for identifiers, DECIMAL for GPA, and ENUM for categorical fields.

---

## Students Table

```
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
```

---

## Teachers Table

```
CREATE TABLE teachers (
  teacher_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  office_number VARCHAR(10)
);
```

---

## Subjects Table

```
CREATE TABLE subjects (
  subject_id INT AUTO_INCREMENT PRIMARY KEY,
  subject_name VARCHAR(100)
);
```

---

## Data Insertion

I inserted realistic test data into each table using `INSERT INTO`.
- 23 student records (diverse in gender, levels, tracks)
- 10 teacher records
- 6 subjects

---

## Data Cleaning & Transformation

### Email and Office Update

```
UPDATE students SET student_email = 'norah99@gmail.com' WHERE student_id = 1;
UPDATE teachers SET office_number = 'B11' WHERE teacher_id = 1;
```

### Table Rename

```
RENAME TABLE students TO students_data;
```

### Add New Column: Age

```
ALTER TABLE students_data ADD age INT;
UPDATE students_data SET age = 16 WHERE student_id = 1;
```
For simplicity, a static age value was added for demonstration purposes.

### Gender Format Fix


The gender column initially used 'M' and 'F'. I updated it to 'Male' and 'Female' by first modifying the ENUM values, then replacing the codes using REPLACE():

```
ALTER TABLE students_data
MODIFY gender ENUM('M', 'F', 'Male', 'Female');

UPDATE students_data
SET gender = REPLACE(gender, 'F', 'Female')
WHERE gender = 'F';

UPDATE students_data
SET gender = REPLACE(gender, 'M', 'Male')
WHERE gender = 'M';
```

### GPA Boost for Low Scores

```
UPDATE students_data SET gpa = gpa + 5 WHERE gpa < 60;
```
## Data Analysis

GPA stats were calculated using aggregate functions (AVG, MAX, MIN…) to evaluate student performance and explore key patterns in the dataset.

- Order by name: `ORDER BY first_name ASC`
- Full name column: `CONCAT(first_name, ' ', last_name)`
- GPA stats: `AVG()`, `MAX()`, `MIN()`, `ROUND()`, `FLOOR()`
- Subjects uppercase: `UPPER(subject_name)`
- Student counts by level and track: `COUNT(*)`, `DISTINCT(track)`
- GPA filters: High and low performers into separate tables:
```
CREATE TABLE top_students AS SELECT * FROM students_data WHERE gpa >= 90;
CREATE TABLE failed_students AS SELECT * FROM students_data WHERE gpa < 60;
```
## Relationships (Joins)

Implemented many-to-many relationships using bridge tables (student_subject, teacher_student) to connect records logically and ensure normalization.

1. Teachers <> Students (Many-to-Many)

```
CREATE TABLE teacher_student (
  teacher_id INT NOT NULL,
  student_id INT NOT NULL,
  PRIMARY KEY (teacher_id, student_id),
  FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
  FOREIGN KEY (student_id) REFERENCES students_data(student_id)
);
```
   
3. Teachers <> Subjects (MAny-to-One)

```
ALTER TABLE teachers
ADD COLUMN subject_id INT,
ADD FOREIGN KEY (subject_id) REFERENCES subjects(subject_id);
```
   
5. Students <> Subjects (Many-to-Many)

```
CREATE TABLE student_subject (
  student_id INT NOT NULL,
  subject_id INT NOT NULL,
  PRIMARY KEY (student_id, subject_id),
  FOREIGN KEY (student_id) REFERENCES students_data(student_id),
  FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);   
```
I inserted sample data into the student_subject and teacher_student bridge tables to verify that the many-to-many joins work correctly.

## Stored Procedure

Show student-subject pairs:

```
DELIMITER //
CREATE PROCEDURE student_info()
BEGIN
  SELECT s.first_name, sub.subject_name
  FROM students_data s
  JOIN student_subject ss ON s.student_id = ss.student_id
  JOIN subjects sub ON ss.subject_id = sub.subject_id;
END //
DELIMITER ;

CALL student_info();
```

## View 

Teacher Info View

```
CREATE VIEW teacher_view AS
SELECT t.first_name, t.office_number, sub.subject_name
FROM teachers t
JOIN teacher_subject ts ON t.teacher_id = ts.teacher_id
JOIN subjects sub ON ts.subject_id = sub.subject_id;
```

### To show the view:

```
SELECT * FROM teacher_view;
```

### To drop the view:

```
DROP VIEW teacher_view;
```

## Index

### Create index on first name:

```
CREATE INDEX idx_student_name ON students_data(first_name);
SHOW INDEX FROM students_data;
DROP INDEX idx_student_name ON students_data;
```

## Notes
- Database schema was normalized.
- Relationships are well defined.
- Data was cleaned and transformed.
- Analytical queries and procedures were implemented.
- Views and indexes were created and tested.

## What I Learned
- How to build, populate, and normalize relational databases.
- How to clean and manipulate data.
- How to create meaningful joins and bridge tables.
- How to automate queries using procedures.
- How to improve performance using views and indexes.
