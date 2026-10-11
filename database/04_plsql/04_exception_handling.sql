
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 04_exception_handling.sql

SET SERVEROUTPUT ON;

-- Example 1: NO_DATA_FOUND
DECLARE
    v_student_name VARCHAR2(120);
BEGIN
    SELECT first_name || ' ' || last_name
    INTO v_student_name
    FROM students
    WHERE student_id = -999;

    DBMS_OUTPUT.PUT_LINE(v_student_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No student found with this ID.');
END;
/

-- Example 2: TOO_MANY_ROWS
DECLARE
    v_student_name VARCHAR2(120);
BEGIN
    SELECT first_name || ' ' || last_name
    INTO v_student_name
    FROM students
    WHERE student_status = 'ACTIVE';

    DBMS_OUTPUT.PUT_LINE(v_student_name);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE(
            'The query returned multiple students.'
        );
END;
/

-- Example 3: ZERO_DIVIDE
DECLARE
    v_result NUMBER;
BEGIN
    v_result := 100 / 0;
    DBMS_OUTPUT.PUT_LINE(v_result);
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Division by zero is not allowed.');
END;
/

-- Example 4: Custom exception and RAISE
DECLARE
    e_invalid_credits EXCEPTION;
    v_credits NUMBER := 0;
BEGIN
    IF v_credits <= 0 THEN
        RAISE e_invalid_credits;
    END IF;
EXCEPTION
    WHEN e_invalid_credits THEN
        DBMS_OUTPUT.PUT_LINE('Credits must be greater than zero.');
END;
/

-- Example 5: SQLCODE and SQLERRM
BEGIN
    INSERT INTO departments (department_id, department_name)
    VALUES (1, 'Duplicate Department');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/
