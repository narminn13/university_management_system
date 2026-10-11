
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: tests/test_constraints.sql
-- Tests: PRIMARY KEY, UNIQUE, NOT NULL, CHECK, FOREIGN KEY

SET SERVEROUTPUT ON;

-- TEST 1: Duplicate primary key must be rejected
DECLARE
    v_rejected BOOLEAN := FALSE;
BEGIN
    BEGIN
        INSERT INTO departments (
            department_id, department_name
        )
        VALUES (1, 'Temporary Duplicate Department');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            v_rejected := TRUE;
    END;

    ROLLBACK;

    IF NOT v_rejected THEN
        RAISE_APPLICATION_ERROR(
            -20101, 'TEST FAILED: Duplicate primary key was accepted.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('TEST 1 PASSED: Duplicate primary key rejected.');
END;
/

-- TEST 2: Duplicate department name must be rejected
DECLARE
    v_rejected BOOLEAN := FALSE;
BEGIN
    BEGIN
        INSERT INTO departments (
            department_id, department_name
        )
        VALUES (9001, 'Computer Science');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            v_rejected := TRUE;
    END;

    ROLLBACK;

    IF NOT v_rejected THEN
        RAISE_APPLICATION_ERROR(
            -20102, 'TEST FAILED: Duplicate department name was accepted.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('TEST 2 PASSED: UNIQUE constraint enforced.');
END;
/

-- TEST 3: Invalid student status must be rejected
DECLARE
    v_rejected BOOLEAN := FALSE;
BEGIN
    BEGIN
        INSERT INTO students (
            student_id, first_name, last_name, email,
            admission_date, student_status, department_id
        )
        VALUES (
            9001, 'Test', 'Student', 'test9001@student.edu',
            SYSDATE, 'INVALID', 1
        );
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2290 THEN
                v_rejected := TRUE;
            ELSE
                RAISE;
            END IF;
    END;

    ROLLBACK;

    IF NOT v_rejected THEN
        RAISE_APPLICATION_ERROR(
            -20103, 'TEST FAILED: Invalid student status was accepted.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('TEST 3 PASSED: CHECK constraint enforced.');
END;
/

-- TEST 4: Missing department must violate the foreign key
DECLARE
    v_rejected BOOLEAN := FALSE;
BEGIN
    BEGIN
        INSERT INTO students (
            student_id, first_name, last_name, email,
            admission_date, student_status, department_id
        )
        VALUES (
            9002, 'Test', 'Student', 'test9002@student.edu',
            SYSDATE, 'ACTIVE', 99999
        );
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2291 THEN
                v_rejected := TRUE;
            ELSE
                RAISE;
            END IF;
    END;

    ROLLBACK;

    IF NOT v_rejected THEN
        RAISE_APPLICATION_ERROR(
            -20104, 'TEST FAILED: Invalid department ID was accepted.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('TEST 4 PASSED: FOREIGN KEY enforced.');
END;
/

-- TEST 5: Missing required department name must be rejected
DECLARE
    v_rejected BOOLEAN := FALSE;
BEGIN
    BEGIN
        INSERT INTO departments (
            department_id, department_name
        )
        VALUES (9003, NULL);
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1400 THEN
                v_rejected := TRUE;
            ELSE
                RAISE;
            END IF;
    END;

    ROLLBACK;

    IF NOT v_rejected THEN
        RAISE_APPLICATION_ERROR(
            -20105, 'TEST FAILED: NULL department name was accepted.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('TEST 5 PASSED: NOT NULL constraint enforced.');
END;
/
