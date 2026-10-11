
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: tests/test_functions.sql

SET SERVEROUTPUT ON;

-- TEST 1: Student average grade
DECLARE
    v_average NUMBER;
BEGIN
    v_average := get_student_average_grade(1);

    IF v_average IS NULL OR v_average <> 91 THEN
        RAISE_APPLICATION_ERROR(
            -20301,
            'TEST FAILED: Unexpected average grade for student 1.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'TEST 1 PASSED: Student average grade = '
        || TO_CHAR(v_average)
    );
END;
/

-- TEST 2: Section enrollment count
DECLARE
    v_count NUMBER;
BEGIN
    v_count := get_section_enrollment_count(4);

    IF v_count <> 2 THEN
        RAISE_APPLICATION_ERROR(
            -20302,
            'TEST FAILED: Expected 2 enrollments in section 4.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'TEST 2 PASSED: Section 4 enrollment count = '
        || TO_CHAR(v_count)
    );
END;
/

-- TEST 3: A student with no grades should return NULL
DECLARE
    v_average NUMBER;
BEGIN
    v_average := get_student_average_grade(8);

    IF v_average IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(
            -20303,
            'TEST FAILED: Expected NULL for a student without grades.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'TEST 3 PASSED: No-grade student returns NULL.'
    );
END;
/

-- TEST 4: An existing section with no enrollments returns zero
DECLARE
    v_count NUMBER;
BEGIN
    -- Find a section without enrollments, if one exists.
    SELECT COUNT(*)
    INTO v_count
    FROM course_sections cs
    WHERE NOT EXISTS (
        SELECT 1
        FROM enrollments e
        WHERE e.section_id = cs.section_id
    );

    IF v_count > 0 THEN
        SELECT get_section_enrollment_count(cs.section_id)
        INTO v_count
        FROM course_sections cs
        WHERE NOT EXISTS (
            SELECT 1
            FROM enrollments e
            WHERE e.section_id = cs.section_id
        )
          AND ROWNUM = 1;

        IF v_count <> 0 THEN
            RAISE_APPLICATION_ERROR(
                -20304,
                'TEST FAILED: Empty section should return zero.'
            );
        END IF;

        DBMS_OUTPUT.PUT_LINE(
            'TEST 4 PASSED: Empty section returns zero.'
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'TEST 4 SKIPPED: Every section has at least one enrollment.'
        );
    END IF;
END;
/
