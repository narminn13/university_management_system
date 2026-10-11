
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 03_cursors.sql

SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_student_grades IS
        SELECT s.student_id,
               s.first_name,
               s.last_name,
               ROUND(AVG(e.grade), 2) AS average_grade
        FROM students s
        LEFT JOIN enrollments e
          ON s.student_id = e.student_id
         AND e.grade IS NOT NULL
        GROUP BY s.student_id, s.first_name, s.last_name
        ORDER BY s.student_id;

BEGIN
    FOR rec IN c_student_grades LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Student ID: ' || rec.student_id
            || ' | Name: ' || rec.first_name || ' ' || rec.last_name
            || ' | Average grade: '
            || NVL(TO_CHAR(rec.average_grade), 'No grades')
        );
    END LOOP;
END;
/

-- Explicit cursor with OPEN, FETCH and CLOSE
DECLARE
    CURSOR c_departments IS
        SELECT department_id, department_name
        FROM departments
        ORDER BY department_id;

    v_department_id   departments.department_id%TYPE;
    v_department_name departments.department_name%TYPE;
BEGIN
    OPEN c_departments;

    LOOP
        FETCH c_departments
        INTO v_department_id, v_department_name;

        EXIT WHEN c_departments%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            v_department_id || ' - ' || v_department_name
        );
    END LOOP;

    CLOSE c_departments;
END;
/
