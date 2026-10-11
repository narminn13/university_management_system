
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 02_insert_instructors.sql

INSERT INTO instructors
(instructor_id, first_name, last_name, email, hire_date, department_id)
VALUES
(1, 'Leyla', 'Mammadova', 'leyla.mammadova@university.edu',
 DATE '2018-09-01', 1);

INSERT INTO instructors
(instructor_id, first_name, last_name, email, hire_date, department_id)
VALUES
(2, 'Rashad', 'Aliyev', 'rashad.aliyev@university.edu',
 DATE '2019-02-15', 1);

INSERT INTO instructors
(instructor_id, first_name, last_name, email, hire_date, department_id)
VALUES
(3, 'Aysel', 'Hasanova', 'aysel.hasanova@university.edu',
 DATE '2020-09-01', 2);

INSERT INTO instructors
(instructor_id, first_name, last_name, email, hire_date, department_id)
VALUES
(4, 'Kamran', 'Huseynov', 'kamran.huseynov@university.edu',
 DATE '2017-01-10', 2);

INSERT INTO instructors
(instructor_id, first_name, last_name, email, hire_date, department_id)
VALUES
(5, 'Nigar', 'Karimova', 'nigar.karimova@university.edu',
 DATE '2021-09-01', 3);

INSERT INTO instructors
(instructor_id, first_name, last_name, email, hire_date, department_id)
VALUES
(6, 'Orkhan', 'Jafarov', 'orkhan.jafarov@university.edu',
 DATE '2016-09-01', 3);

INSERT INTO instructors
(instructor_id, first_name, last_name, email, hire_date, department_id)
VALUES
(7, 'Sabina', 'Ismayilova', 'sabina.ismayilova@university.edu',
 DATE '2022-02-01', 4);

INSERT INTO instructors
(instructor_id, first_name, last_name, email, hire_date, department_id)
VALUES
(8, 'Tural', 'Mehdiyev', 'tural.mehdiyev@university.edu',
 DATE '2018-03-12', 4);

INSERT INTO instructors
(instructor_id, first_name, last_name, email, hire_date, department_id)
VALUES
(9, 'Gunel', 'Abbasova', 'gunel.abbasova@university.edu',
 DATE '2020-01-20', 5);

INSERT INTO instructors
(instructor_id, first_name, last_name, email, hire_date, department_id)
VALUES
(10, 'Elvin', 'Safarov', 'elvin.safarov@university.edu',
 DATE '2019-08-15', 5);

COMMIT;
