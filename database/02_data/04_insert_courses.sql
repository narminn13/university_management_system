
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 04_insert_courses.sql

INSERT ALL
    INTO courses VALUES (1, 'CS101', 'Introduction to Programming', 4, 1)
    INTO courses VALUES (2, 'CS201', 'Data Structures and Algorithms', 5, 1)
    INTO courses VALUES (3, 'CS301', 'Database Systems', 4, 1)
    INTO courses VALUES (4, 'IT101', 'Information Systems Fundamentals', 3, 2)
    INTO courses VALUES (5, 'IT201', 'Web Application Development', 4, 2)
    INTO courses VALUES (6, 'IT301', 'Data Analytics', 4, 2)
    INTO courses VALUES (7, 'MTH101', 'Calculus I', 4, 3)
    INTO courses VALUES (8, 'MTH201', 'Linear Algebra', 3, 3)
    INTO courses VALUES (9, 'BUS101', 'Principles of Management', 3, 4)
    INTO courses VALUES (10, 'BUS201', 'Business Statistics', 3, 4)
    INTO courses VALUES (11, 'ENG101', 'Engineering Fundamentals', 4, 5)
    INTO courses VALUES (12, 'ENG201', 'Project Management for Engineers', 3, 5)
SELECT 1 FROM dual;

COMMIT;
