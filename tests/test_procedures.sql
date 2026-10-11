
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: tests/test_procedures.sql

SET SERVEROUTPUT ON;

-- TEST 1: Register an active student in a section
DECLARE
    v_before NUMBER;
    v_after  NUMBER;
BEGIN
    SAVEPOINT before_registration_test;

    SELECT COUNT(*)
    INTO v_before
    FROM enrollments
    WHERE student_id = 1
      AND section_id = 3;

    IF v_before > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20201,
            'Choose another student/section pair for this test.'
        );
    END IF;

    register_student_for_section(
        p_student_id => 1,
        p_section_id => 3
    );

    SELECT COUNT(*)
    INTO v_after
    FROM enrollments
    WHERE student_id = 1
      AND section_id = 3
      AND enrollment_status = 'ENROLLED';

    IF v_after <> 1 THEN
        RAISE_APPLICATION_ERROR(
            -20202,
            'TEST FAILED: Registration was not created.'
        );
    END IF;

    ROLLBACK TO before_registration_test;

    DBMS_OUTPUT.PUT_LINE(
        'TEST 1 PASSED: Registration worked and was rolled back.'
    );
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO before_registration_test;
        RAISE;
END;
/

-- TEST 2: A nonexistent student must be rejected
DECLARE
    v_rejected BOOLEAN := FALSE;
BEGIN
    BEGIN
        register_student_for_section(
            p_student_id => -999,
            p_section_id => 1
        );
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -20004 THEN
                v_rejected := TRUE;
            ELSE
                RAISE;
            END IF;
    END;

    IF NOT v_rejected THEN
        RAISE_APPLICATION_ERROR(
            -20203,
            'TEST FAILED: Nonexistent student was not rejected.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'TEST 2 PASSED: Nonexistent student rejected.'
    );
END;
/

-- TEST 3: Duplicate registration must be rejected
DECLARE
    v_rejected BOOLEAN := FALSE;
BEGIN
    BEGIN
        register_student_for_section(
            p_student_id => 1,
            p_section_id => 4
        );
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -20002 THEN
                v_rejected := TRUE;
            ELSE
                RAISE;
            END IF;
    END;

    IF NOT v_rejected THEN
        RAISE_APPLICATION_ERROR(
            -20204,
            'TEST FAILED: Duplicate registration was not rejected.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'TEST 3 PASSED: Duplicate registration rejected.'
    );
END;
/
