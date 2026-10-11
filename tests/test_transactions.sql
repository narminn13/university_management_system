
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: tests/test_transactions.sql

SET SERVEROUTPUT ON;

-- TEST 1: Roll back an UPDATE
DECLARE
    v_original_status students.student_status%TYPE;
    v_current_status  students.student_status%TYPE;
BEGIN
    SAVEPOINT before_update_test;

    SELECT student_status
    INTO v_original_status
    FROM students
    WHERE student_id = 1;

    UPDATE students
    SET student_status =
        CASE
            WHEN v_original_status = 'ACTIVE' THEN 'SUSPENDED'
            ELSE 'ACTIVE'
        END
    WHERE student_id = 1;

    ROLLBACK TO before_update_test;

    SELECT student_status
    INTO v_current_status
    FROM students
    WHERE student_id = 1;

    IF v_current_status <> v_original_status THEN
        RAISE_APPLICATION_ERROR(
            -20401,
            'TEST FAILED: Rollback did not restore the original status.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'TEST 1 PASSED: UPDATE was rolled back successfully.'
    );
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO before_update_test;
        RAISE;
END;
/

-- TEST 2: Roll back an INSERT
DECLARE
    v_count NUMBER;
BEGIN
    SAVEPOINT before_insert_test;

    INSERT INTO departments (
        department_id,
        department_name,
        office_location
    )
    VALUES (
        9901,
        'Temporary Test Department',
        'Test Office'
    );

    SELECT COUNT(*)
    INTO v_count
    FROM departments
    WHERE department_id = 9901;

    IF v_count <> 1 THEN
        RAISE_APPLICATION_ERROR(
            -20402,
            'TEST FAILED: Test department was not inserted.'
        );
    END IF;

    ROLLBACK TO before_insert_test;

    SELECT COUNT(*)
    INTO v_count
    FROM departments
    WHERE department_id = 9901;

    IF v_count <> 0 THEN
        RAISE_APPLICATION_ERROR(
            -20403,
            'TEST FAILED: Inserted department still exists after rollback.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'TEST 2 PASSED: INSERT was rolled back successfully.'
    );
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO before_insert_test;
        RAISE;
END;
/

-- TEST 3: Verify that a savepoint can undo only later changes
DECLARE
    v_original_location departments.office_location%TYPE;
    v_current_location  departments.office_location%TYPE;
BEGIN
    SAVEPOINT before_savepoint_test;

    SELECT office_location
    INTO v_original_location
    FROM departments
    WHERE department_id = 1;

    UPDATE departments
    SET office_location = 'Temporary Location'
    WHERE department_id = 1;

    SAVEPOINT after_first_update;

    UPDATE departments
    SET office_location = 'Another Temporary Location'
    WHERE department_id = 1;

    ROLLBACK TO after_first_update;

    SELECT office_location
    INTO v_current_location
    FROM departments
    WHERE department_id = 1;

    IF v_current_location <> 'Temporary Location' THEN
        RAISE_APPLICATION_ERROR(
            -20404,
            'TEST FAILED: Rollback to savepoint behaved unexpectedly.'
        );
    END IF;

    ROLLBACK TO before_savepoint_test;

    SELECT office_location
    INTO v_current_location
    FROM departments
    WHERE department_id = 1;

    IF v_current_location <> v_original_location THEN
        RAISE_APPLICATION_ERROR(
            -20405,
            'TEST FAILED: Original location was not restored.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'TEST 3 PASSED: SAVEPOINT and partial rollback worked.'
    );
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO before_savepoint_test;
        RAISE;
END;
/
