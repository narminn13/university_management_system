
-- File: 05_window_functions.sql
-- Analytic/window functions

-- Q1. Rank students by grade
SELECT s.student_id,
       s.first_name,
       s.last_name,
       e.grade,
       RANK() OVER (ORDER BY e.grade DESC) AS grade_rank
FROM students s
JOIN enrollments e
  ON s.student_id = e.student_id
WHERE e.grade IS NOT NULL;

-- Q2. Rank students within each course
SELECT c.course_title,
       s.first_name || ' ' || s.last_name AS student_name,
       e.grade,
       DENSE_RANK() OVER (
           PARTITION BY c.course_id
           ORDER BY e.grade DESC
       ) AS course_rank
FROM enrollments e
JOIN students s
  ON e.student_id = s.student_id
JOIN course_sections cs
  ON e.section_id = cs.section_id
JOIN courses c
  ON cs.course_id = c.course_id
WHERE e.grade IS NOT NULL;

-- Q3. Assign a row number to students by surname
SELECT student_id,
       first_name,
       last_name,
       ROW_NUMBER() OVER (
           ORDER BY last_name, first_name
       ) AS row_num
FROM students;

-- Q4. Compare each grade with the overall average
SELECT student_id,
       grade,
       ROUND(AVG(grade) OVER (), 2) AS overall_average
FROM enrollments
WHERE grade IS NOT NULL;

-- Q5. Compare each student's grade with their average grade
SELECT student_id,
       section_id,
       grade,
       ROUND(
           AVG(grade) OVER (PARTITION BY student_id),
           2
       ) AS student_average
FROM enrollments
WHERE grade IS NOT NULL;

-- Q6. Show the previous grade within each student's records
SELECT student_id,
       enrollment_id,
       grade,
       LAG(grade) OVER (
           PARTITION BY student_id
           ORDER BY enrollment_date, enrollment_id
       ) AS previous_grade
FROM enrollments
WHERE grade IS NOT NULL;

-- Q7. Show the next grade within each student's records
SELECT student_id,
       enrollment_id,
       grade,
       LEAD(grade) OVER (
           PARTITION BY student_id
           ORDER BY enrollment_date, enrollment_id
       ) AS next_grade
FROM enrollments
WHERE grade IS NOT NULL;

-- Q8. Calculate a running average of grades
SELECT enrollment_id,
       enrollment_date,
       grade,
       ROUND(
           AVG(grade) OVER (
               ORDER BY enrollment_date, enrollment_id
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ),
           2
       ) AS running_average
FROM enrollments
WHERE grade IS NOT NULL;

-- Q9. Find the highest grade per course
SELECT course_title,
       student_name,
       grade
FROM (
    SELECT c.course_title,
           s.first_name || ' ' || s.last_name AS student_name,
           e.grade,
           ROW_NUMBER() OVER (
               PARTITION BY c.course_id
               ORDER BY e.grade DESC, e.enrollment_id
           ) AS rn
    FROM enrollments e
    JOIN students s
      ON e.student_id = s.student_id
    JOIN course_sections cs
      ON e.section_id = cs.section_id
    JOIN courses c
      ON cs.course_id = c.course_id
    WHERE e.grade IS NOT NULL
)
WHERE rn = 1;

-- Q10. Calculate each student's percentage of all enrollments
SELECT student_id,
       COUNT(*) AS enrollment_count,
       ROUND(
           100 * COUNT(*) / SUM(COUNT(*)) OVER (),
           2
       ) AS enrollment_percentage
FROM enrollments
GROUP BY student_id
ORDER BY enrollment_count DESC, student_id;
