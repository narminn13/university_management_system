
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: instructor_workload_summary.sql
-- Purpose: Instructor workload summary

CREATE OR REPLACE VIEW instructor_workload_summary AS
SELECT
    i.instructor_id,
    i.first_name,
    i.last_name,
    i.email,
    d.department_name,
    COUNT(DISTINCT cs.section_id) AS total_sections,
    COUNT(
        CASE
            WHEN e.enrollment_status IN ('ENROLLED', 'COMPLETED')
            THEN e.enrollment_id
        END
    ) AS total_student_enrollments,
    COUNT(
        CASE
            WHEN e.enrollment_status = 'ENROLLED'
            THEN e.enrollment_id
        END
    ) AS active_enrollments,
    COUNT(
        CASE
            WHEN e.enrollment_status = 'COMPLETED'
            THEN e.enrollment_id
        END
    ) AS completed_enrollments
FROM instructors i
JOIN departments d
    ON i.department_id = d.department_id
LEFT JOIN course_sections cs
    ON i.instructor_id = cs.instructor_id
LEFT JOIN enrollments e
    ON cs.section_id = e.section_id
GROUP BY
    i.instructor_id,
    i.first_name,
    i.last_name,
    i.email,
    d.department_name;

-- Test
SELECT *
FROM instructor_workload_summary
ORDER BY total_sections DESC, last_name;
