
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 01_procedures.sql

CREATE OR REPLACE PROCEDURE register_student_for_section (
    p_student_id IN NUMBER,
    p_section_id IN NUMBER
)
AS
    v_student_status students.student_status%TYPE;
    v_capacity       course_sections.capacity%TYPE;
    v_enrolled_count NUMBER;
    v_existing_count NUMBER;
BEGIN
    -- Check whether the student exists and is active
    SELECT student_status
    INTO v_student_status
    FROM students
    WHERE student_id = p_student_id;

    IF v_student_status <> 'ACTIVE' THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Only active students can enroll.'
        );
    END IF;

    -- Check whether the section exists and get its capacity
    SELECT capacity
    INTO v_capacity
    FROM course_sections
    WHERE section_id = p_section_id;

    -- Prevent duplicate enrollment
    SELECT COUNT(*)
    INTO v_existing_count
    FROM enrollments
    WHERE student_id = p_student_id
      AND section_id = p_section_id
      AND enrollment_status <> 'WITHDRAWN';

    IF v_existing_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Student is already enrolled in this section.'
        );
    END IF;

    -- Count enrollments that occupy a seat
    SELECT COUNT(*)
    INTO v_enrolled_count
    FROM enrollments
    WHERE section_id = p_section_id
      AND enrollment_status IN ('ENROLLED', 'COMPLETED');

    IF v_enrolled_count >= v_capacity THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'This course section is full.'
        );
    END IF;

    INSERT INTO enrollments (
        enrollment_id,
        student_id,
        section_id,
        enrollment_date,
        enrollment_status,
        grade
    )
    VALUES (
        (SELECT NVL(MAX(enrollment_id), 0) + 1 FROM enrollments),
        p_student_id,
        p_section_id,
        SYSDATE,
        'ENROLLED',
        NULL
    );

    DBMS_OUTPUT.PUT_LINE('Student successfully enrolled.');

    -- Transaction control is intentionally left to the caller.
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'Student or course section was not found.'
        );
END;
/
