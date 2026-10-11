
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: course_enrollment_summary.sql
-- Purpose: Enrollment and capacity summary for course sections

CREATE OR REPLACE VIEW course_enrollment_summary AS
SELECT
    cs.section_id,
    c.course_id,
    c.course_code,
    c.course_title,
    d.department_name,
    sem.semester_name,
    sem.academic_year,
    cs.section_number,
    cs.capacity,
    COUNT(
        CASE
            WHEN e.enrollment_status IN ('ENROLLED', 'COMPLETED')
            THEN e.enrollment_id
        END
    ) AS enrolled_students,
    cs.capacity -
    COUNT(
        CASE
            WHEN e.enrollment_status IN ('ENROLLED', 'COMPLETED')
            THEN e.enrollment_id
        END
    ) AS available_places,
    ROUND(
        100 * COUNT(
            CASE
                WHEN e.enrollment_status IN ('ENROLLED', 'COMPLETED')
                THEN e.enrollment_id
            END
        ) / NULLIF(cs.capacity, 0),
        2
    ) AS occupancy_percentage
FROM course_sections cs
JOIN courses c
    ON cs.course_id = c.course_id
JOIN departments d
    ON c.department_id = d.department_id
JOIN semesters sem
    ON cs.semester_id = sem.semester_id
LEFT JOIN enrollments e
    ON cs.section_id = e.section_id
GROUP BY
    cs.section_id,
    c.course_id,
    c.course_code,
    c.course_title,
    d.department_name,
    sem.semester_name,
    sem.academic_year,
    cs.section_number,
    cs.capacity;

-- Test
SELECT *
FROM course_enrollment_summary
ORDER BY occupancy_percentage DESC, course_code;
