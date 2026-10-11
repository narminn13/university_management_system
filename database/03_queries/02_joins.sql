
-- File: 02_joins.sql
-- INNER JOIN and LEFT JOIN

-- Q1. Students with their department names
SELECT s.student_id,
       s.first_name,
       s.last_name,
       d.department_name
FROM students s
JOIN departments d
  ON s.department_id = d.department_id
ORDER BY d.department_name, s.last_name;

-- Q2. Instructors with their departments
SELECT i.instructor_id,
       i.first_name,
       i.last_name,
       d.department_name
FROM instructors i
JOIN departments d
  ON i.department_id = d.department_id;

-- Q3. Courses with their departments
SELECT c.course_code,
       c.course_title,
       c.credits,
       d.department_name
FROM courses c
JOIN departments d
  ON c.department_id = d.department_id;

-- Q4. Sections with course, semester and instructor details
SELECT cs.section_id,
       c.course_code,
       c.course_title,
       sem.semester_name,
       sem.academic_year,
       i.first_name || ' ' || i.last_name AS instructor_name,
       cs.classroom
FROM course_sections cs
JOIN courses c
  ON cs.course_id = c.course_id
JOIN semesters sem
  ON cs.semester_id = sem.semester_id
JOIN instructors i
  ON cs.instructor_id = i.instructor_id
ORDER BY sem.start_date, c.course_code;

-- Q5. Students and their enrollment details
SELECT s.student_id,
       s.first_name,
       s.last_name,
       c.course_title,
       e.enrollment_status,
       e.grade
FROM students s
JOIN enrollments e
  ON s.student_id = e.student_id
JOIN course_sections cs
  ON e.section_id = cs.section_id
JOIN courses c
  ON cs.course_id = c.course_id
ORDER BY s.student_id;

-- Q6. Show all students, including those without enrollments
SELECT s.student_id,
       s.first_name,
       s.last_name,
       e.enrollment_id
FROM students s
LEFT JOIN enrollments e
  ON s.student_id = e.student_id
ORDER BY s.student_id;

-- Q7. Show all courses, including courses without sections
SELECT c.course_code,
       c.course_title,
       cs.section_id
FROM courses c
LEFT JOIN course_sections cs
  ON c.course_id = cs.course_id
ORDER BY c.course_code;

-- Q8. Enrollment count for every course
SELECT c.course_code,
       c.course_title,
       COUNT(e.enrollment_id) AS enrollment_count
FROM courses c
LEFT JOIN course_sections cs
  ON c.course_id = cs.course_id
LEFT JOIN enrollments e
  ON cs.section_id = e.section_id
GROUP BY c.course_id, c.course_code, c.course_title
ORDER BY enrollment_count DESC;

-- Q9. Departments and student counts
SELECT d.department_name,
       COUNT(s.student_id) AS student_count
FROM departments d
LEFT JOIN students s
  ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name
ORDER BY student_count DESC;

-- Q10. Students and their instructors for each enrolled course
SELECT s.first_name || ' ' || s.last_name AS student_name,
       c.course_title,
       i.first_name || ' ' || i.last_name AS instructor_name
FROM enrollments e
JOIN students s
  ON e.student_id = s.student_id
JOIN course_sections cs
  ON e.section_id = cs.section_id
JOIN courses c
  ON cs.course_id = c.course_id
JOIN instructors i
  ON cs.instructor_id = i.instructor_id
ORDER BY student_name, c.course_title;
