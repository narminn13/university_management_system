
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: student_academic_summary.sql
-- Purpose: Academic summary for every student

CREATE OR REPLACE VIEW student_academic_summary AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    s.email,
    s.student_status,
    d.department_name,
    COUNT(e.enrollment_id) AS total_enrollments,
    SUM(
        CASE
            WHEN e.enrollment_status = 'COMPLETED' THEN 1
            ELSE 0
        END
    ) AS completed_courses,
    SUM(
        CASE
            WHEN e.enrollment_status = 'ENROLLED' THEN 1
            ELSE 0
        END
    ) AS current_enrollments,
    SUM(
        CASE
            WHEN e.enrollment_status = 'WITHDRAWN' THEN 1
            ELSE 0
        END
    ) AS withdrawn_courses,
    ROUND(AVG(e.grade), 2) AS average_grade,
    MAX(e.grade) AS highest_grade,
    MIN(e.grade) AS lowest_grade
FROM students s
JOIN departments d
    ON s.department_id = d.department_id
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name,
    s.email,
    s.student_status,
    d.department_name;

-- Test
SELECT *
FROM student_academic_summary
ORDER BY student_id;
