
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 02_functions.sql

CREATE OR REPLACE FUNCTION get_student_average_grade (
    p_student_id IN NUMBER
)
RETURN NUMBER
AS
    v_average_grade NUMBER;
BEGIN
    SELECT ROUND(AVG(grade), 2)
    INTO v_average_grade
    FROM enrollments
    WHERE student_id = p_student_id
      AND grade IS NOT NULL;

    RETURN v_average_grade;
END;


CREATE OR REPLACE FUNCTION get_section_enrollment_count (
    p_section_id IN NUMBER
)
RETURN NUMBER
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM enrollments
    WHERE section_id = p_section_id
      AND enrollment_status IN ('ENROLLED', 'COMPLETED');

    RETURN v_count;
END;


-- Example 1: Get a student's average grade
SELECT student_id,
       first_name,
       last_name,
       get_student_average_grade(student_id) AS average_grade
FROM students
ORDER BY student_id;

-- Example 2: Get enrollment count for each section
SELECT section_id,
       capacity,
       get_section_enrollment_count(section_id) AS enrolled_count
FROM course_sections
ORDER BY section_id;
