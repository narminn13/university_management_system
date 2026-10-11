
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 05_transactions.sql

SET SERVEROUTPUT ON;

-- Example 1: SAVEPOINT and ROLLBACK
-- This test changes student 1 temporarily, then reverses the change.

DECLARE
    v_original_status students.student_status%TYPE;
BEGIN
    SELECT student_status
    INTO v_original_status
    FROM students
    WHERE student_id = 1;

    SAVEPOINT before_status_update;

    UPDATE students
    SET student_status = 'SUSPENDED'
    WHERE student_id = 1;

    DBMS_OUTPUT.PUT_LINE(
        'Temporary status: SUSPENDED'
    );

    ROLLBACK TO before_status_update;

    DBMS_OUTPUT.PUT_LINE(
        'Transaction rolled back.'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Original status was: ' || v_original_status
    );
END;
/

-- Example 2: Explicit transaction with UPDATE
-- Run the statements individually in SQL Commands if needed.
-- Do not COMMIT unless you intentionally want to keep the change.

-- SAVEPOINT before_student_update;
-- UPDATE students
-- SET student_status = 'SUSPENDED'
-- WHERE student_id = 1;
-- SELECT student_id, student_status
-- FROM students
-- WHERE student_id = 1;
-- ROLLBACK TO before_student_update;

-- Example 3: COMMIT
-- COMMIT permanently saves the current transaction's changes.
-- Use COMMIT only after verifying the intended changes.

-- COMMIT;

-- Verify student 1's status after the rollback test
SELECT student_id, student_status
FROM students
WHERE student_id = 1;
