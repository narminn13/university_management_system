
-- File: 03_subqueries_ctes.sql
-- Subqueries and Common Table Expressions

-- Q1. Courses with above-average credit values
SELECT course_code, course_title, credits
FROM courses
WHERE credits > (
    SELECT AVG(credits)
    FROM courses
);

-- Q2. Students enrolled in at least one course
SELECT student_id, first_name, last_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
);

-- Q3. Students without any enrollment
SELECT student_id, first_name, last_name
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
);

-- Q4. Courses with enrollment counts above the average course count
WITH course_counts AS (
    SELECT c.course_id,
           c.course_code,
           c.course_title,
           COUNT(e.enrollment_id) AS total_enrollments
    FROM courses c
    LEFT JOIN course_sections cs
      ON c.course_id = cs.course_id
    LEFT JOIN enrollments e
      ON cs.section_id = e.section_id
    GROUP BY c.course_id, c.course_code, c.course_title
)
SELECT course_code, course_title, total_enrollments
FROM course_counts
WHERE total_enrollments > (
    SELECT AVG(total_enrollments)
    FROM course_counts
);

-- Q5. Students whose grades are above the overall average
SELECT s.student_id,
       s.first_name,
       s.last_name,
       e.grade
FROM students s
JOIN enrollments e
  ON s.student_id = e.student_id
WHERE e.grade > (
    SELECT AVG(grade)
    FROM enrollments
    WHERE grade IS NOT NULL
);

-- Q6. The highest-graded enrollment(s)
SELECT s.first_name,
       s.last_name,
       c.course_title,
       e.grade
FROM enrollments e
JOIN students s
  ON e.student_id = s.student_id
JOIN course_sections cs
  ON e.section_id = cs.section_id
JOIN courses c
  ON cs.course_id = c.course_id
WHERE e.grade = (
    SELECT MAX(grade)
    FROM enrollments
);

-- Q7. Departments with more students than the average department size
WITH department_counts AS (
    SELECT d.department_id,
           d.department_name,
           COUNT(s.student_id) AS student_count
    FROM departments d
    LEFT JOIN students s
      ON d.department_id = s.department_id
    GROUP BY d.department_id, d.department_name
)
SELECT department_name, student_count
FROM department_counts
WHERE student_count > (
    SELECT AVG(student_count)
    FROM department_counts
);

-- Q8. Students with grades above their own average
SELECT s.student_id,
       s.first_name,
       s.last_name,
       e.grade
FROM students s
JOIN enrollments e
  ON s.student_id = e.student_id
WHERE e.grade > (
    SELECT AVG(e2.grade)
    FROM enrollments e2
    WHERE e2.student_id = s.student_id
      AND e2.grade IS NOT NULL
);

-- Q9. Courses that have at least one prerequisite
SELECT c.course_code, c.course_title
FROM courses c
WHERE EXISTS (
    SELECT 1
    FROM course_prerequisites cp
    WHERE cp.course_id = c.course_id
);

-- Q10. Courses with no sections
SELECT c.course_code, c.course_title
FROM courses c
WHERE NOT EXISTS (
    SELECT 1
    FROM course_sections cs
    WHERE cs.course_id = c.course_id
);
