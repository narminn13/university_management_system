
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: department_statistics.sql
-- Purpose: Department-level statistics

CREATE OR REPLACE VIEW department_statistics AS
SELECT
    d.department_id,
    d.department_name,
    d.office_location,
    (
        SELECT COUNT(*)
        FROM students s
        WHERE s.department_id = d.department_id
    ) AS total_students,
    (
        SELECT COUNT(*)
        FROM instructors i
        WHERE i.department_id = d.department_id
    ) AS total_instructors,
    (
        SELECT COUNT(*)
        FROM courses c
        WHERE c.department_id = d.department_id
    ) AS total_courses,
    (
        SELECT COUNT(*)
        FROM course_sections cs
        JOIN courses c
            ON cs.course_id = c.course_id
        WHERE c.department_id = d.department_id
    ) AS total_sections
FROM departments d;

-- Test
SELECT *
FROM department_statistics
ORDER BY department_id;
