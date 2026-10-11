
-- File: 04_aggregate_functions.sql
-- Aggregate functions, GROUP BY and HAVING

-- Q1. Total number of students
SELECT COUNT(*) AS total_students
FROM students;

-- Q2. Number of students in each department
SELECT d.department_name,
       COUNT(s.student_id) AS student_count
FROM departments d
LEFT JOIN students s
  ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name
ORDER BY student_count DESC;

-- Q3. Average, minimum and maximum assigned grade
SELECT ROUND(AVG(grade), 2) AS average_grade,
       MIN(grade) AS minimum_grade,
       MAX(grade) AS maximum_grade
FROM enrollments
WHERE grade IS NOT NULL;

-- Q4. Enrollment counts by status
SELECT enrollment_status,
       COUNT(*) AS total
FROM enrollments
GROUP BY enrollment_status
ORDER BY total DESC;

-- Q5. Courses with more than one enrollment
SELECT c.course_code,
       c.course_title,
       COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
JOIN course_sections cs
  ON c.course_id = cs.course_id
JOIN enrollments e
  ON cs.section_id = e.section_id
GROUP BY c.course_id, c.course_code, c.course_title
HAVING COUNT(e.enrollment_id) > 1
ORDER BY total_enrollments DESC;

-- Q6. Average grade for each course
SELECT c.course_code,
       c.course_title,
       ROUND(AVG(e.grade), 2) AS average_grade
FROM courses c
JOIN course_sections cs
  ON c.course_id = cs.course_id
JOIN enrollments e
  ON cs.section_id = e.section_id
WHERE e.grade IS NOT NULL
GROUP BY c.course_id, c.course_code, c.course_title
ORDER BY average_grade DESC;

-- Q7. Total credits offered by each department
SELECT d.department_name,
       SUM(c.credits) AS total_course_credits
FROM departments d
LEFT JOIN courses c
  ON d.department_id = c.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_course_credits DESC NULLS LAST;

-- Q8. Number of sections taught by each instructor
SELECT i.instructor_id,
       i.first_name || ' ' || i.last_name AS instructor_name,
       COUNT(cs.section_id) AS section_count
FROM instructors i
LEFT JOIN course_sections cs
  ON i.instructor_id = cs.instructor_id
GROUP BY i.instructor_id, i.first_name, i.last_name
ORDER BY section_count DESC;

-- Q9. Students with at least two enrollment records
SELECT s.student_id,
       s.first_name,
       s.last_name,
       COUNT(e.enrollment_id) AS enrollment_count
FROM students s
JOIN enrollments e
  ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.enrollment_id) >= 2
ORDER BY enrollment_count DESC;

-- Q10. Grade distribution
SELECT CASE
           WHEN grade >= 90 THEN 'A: 90-100'
           WHEN grade >= 80 THEN 'B: 80-89.99'
           WHEN grade >= 70 THEN 'C: 70-79.99'
           WHEN grade >= 60 THEN 'D: 60-69.99'
           ELSE 'F: Below 60'
       END AS grade_band,
       COUNT(*) AS student_count
FROM enrollments
WHERE grade IS NOT NULL
GROUP BY CASE
             WHEN grade >= 90 THEN 'A: 90-100'
             WHEN grade >= 80 THEN 'B: 80-89.99'
             WHEN grade >= 70 THEN 'C: 70-79.99'
             WHEN grade >= 60 THEN 'D: 60-69.99'
             ELSE 'F: Below 60'
         END
ORDER BY grade_band;
