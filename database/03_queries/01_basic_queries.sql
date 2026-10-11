
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 01_basic_queries.sql
-- Basic SELECT, WHERE, ORDER BY, DISTINCT

-- Q1. Display all departments
SELECT *
FROM departments
ORDER BY department_id;

-- Q2. Display all students alphabetically
SELECT student_id, first_name, last_name, email
FROM students
ORDER BY last_name, first_name;

-- Q3. Find active students
SELECT student_id, first_name, last_name
FROM students
WHERE student_status = 'ACTIVE';

-- Q4. Find students admitted in 2023
SELECT student_id, first_name, last_name, admission_date
FROM students
WHERE admission_date >= DATE '2023-01-01'
  AND admission_date < DATE '2024-01-01';

-- Q5. Find courses worth at least 4 credits
SELECT course_code, course_title, credits
FROM courses
WHERE credits >= 4
ORDER BY credits DESC;

-- Q6. Display unique student statuses
SELECT DISTINCT student_status
FROM students;

-- Q7. Find instructors hired after 2019
SELECT instructor_id, first_name, last_name, hire_date
FROM instructors
WHERE hire_date >= DATE '2020-01-01'
ORDER BY hire_date;

-- Q8. Search for courses whose titles contain "Data"
SELECT course_code, course_title
FROM courses
WHERE LOWER(course_title) LIKE '%data%';

-- Q9. Find sections with capacity of at least 30
SELECT section_id, section_number, capacity, classroom
FROM course_sections
WHERE capacity >= 30
ORDER BY capacity DESC;

-- Q10. Display enrollments with assigned grades
SELECT enrollment_id, student_id, section_id, grade
FROM enrollments
WHERE grade IS NOT NULL
ORDER BY grade DESC;
