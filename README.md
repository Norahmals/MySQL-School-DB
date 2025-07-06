## 📊 School Database Project (MySQL) 

This project was built as the final implementation of both SQL 101 and SQL 102 courses on the [Satr Platform](https://satr.codes). It simulates a basic school system, including students, teachers, and subjects. The project covers schema creation, data insertion, data cleaning, and exploratory data analysis using MySQL.

---

## Project Overview

I created and managed a school database from scratch. The process involved:

- Defining and creating normalized tables.
- Inserting realistic records.
- Performing updates and transformations for data cleaning.
- Writing analytical queries to extract meaningful insights.

---

## Schema Design

I created three main tables:

- `students`: Contains personal and academic data.
- `teachers`: Stores basic info and office numbers.
- `subjects`: Stores subject names.

All primary keys are `AUTO_INCREMENT`, and columns were typed appropriately using `VARCHAR`, `INT`, `DECIMAL`, and `ENUM` types.

---

## Data Insertion

I inserted realistic records using `INSERT INTO`:

- 23 student records covering both genders, tracks (Science/Arts), and various levels.
- 10 teacher records.
- 6 subject records.

---

## Data Cleaning & Updates

Several updates and improvements were applied, including:

- Updating specific values (e.g., student email and office numbers).
- Renaming the `students` table to `students_data` for clarity.
- Adding a new column `age` using `ALTER TABLE` and updating it for certain students.
- Updating GPA for students who scored below 60 by adding +5 using:
  ```sql
  UPDATE students_data
  SET gpa = gpa + 5
  WHERE gpa < 60;

## Gender Transformation

Initially, the `gender` column was defined as `ENUM('M', 'F')`, which prevented updating the values to `'Male'` and `'Female'`. To enable this, I altered the column to accept new values:

```
ALTER TABLE students_data
MODIFY gender ENUM('M', 'F', 'Male', 'Female');
```

Then I replaced the short codes with full strings using the REPLACE() function:
```
UPDATE students_data
SET gender = REPLACE(gender, 'F', 'Female')
WHERE gender = 'F';

UPDATE students_data
SET gender = REPLACE(gender, 'M', 'Male')
WHERE gender = 'M';
```
This approach avoided the need for CASE statements and directly transformed the values inside the table.

## Exploratory Analysis

I wrote SQL queries to answer questions and explore the data:

 • Ordered students alphabetically.

 • Combined first and last names using CONCAT().

 • Used LENGTH() to filter names of specific length.

 • Created two new tables: top_students (GPA ≥ 90) and failed_students (GPA < 60).

 • Used aggregate functions: AVG(), MAX(), MIN(), ROUND(), FLOOR().

 • Displayed subject names in uppercase using UPPER().

 • Counted students in specific levels with COUNT(*).

 • Listed unique tracks using DISTINCT.

## Key SQL Concepts Practiced

 • CREATE DATABASE, USE, CREATE TABLE

 • INSERT INTO, UPDATE, RENAME, ALTER, MODIFY

 • SELECT, ORDER BY, WHERE, BETWEEN, DISTINCT

 • CASE, CONCAT, REPLACE, LENGTH, UPPER

 • Aggregate functions: AVG, MAX, MIN, ROUND, FLOOR

 • Filtering with WHERE, AND

This project applies what I learned in SQL 101 & 102. It showcases my ability to:
 • Design and manage relational databases.
 • Clean and transform data.
 • Write meaningful queries to derive insights.
