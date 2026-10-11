
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 01_create_tables.sql

CREATE TABLE departments (
    department_id   NUMBER,
    department_name VARCHAR2(100),
    office_location VARCHAR2(100),
    created_at      TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE TABLE students (
    student_id      NUMBER,
    first_name      VARCHAR2(50),
    last_name       VARCHAR2(50),
    email           VARCHAR2(150),
    date_of_birth   DATE,
    admission_date  DATE,
    student_status  VARCHAR2(20),
    department_id   NUMBER
);

CREATE TABLE instructors (
    instructor_id NUMBER,
    first_name    VARCHAR2(50),
    last_name     VARCHAR2(50),
    email         VARCHAR2(150),
    hire_date     DATE,
    department_id NUMBER
);

CREATE TABLE courses (
    course_id     NUMBER,
    course_code   VARCHAR2(20),
    course_title  VARCHAR2(150),
    credits       NUMBER(2),
    department_id NUMBER
);

CREATE TABLE course_prerequisites (
    course_id              NUMBER,
    prerequisite_course_id NUMBER
);

CREATE TABLE semesters (
    semester_id   NUMBER,
    semester_name VARCHAR2(50),
    academic_year VARCHAR2(9),
    start_date    DATE,
    end_date      DATE
);

CREATE TABLE course_sections (
    section_id     NUMBER,
    course_id      NUMBER,
    semester_id    NUMBER,
    instructor_id  NUMBER,
    section_number VARCHAR2(10),
    capacity       NUMBER(3),
    classroom      VARCHAR2(50)
);

CREATE TABLE enrollments (
    enrollment_id     NUMBER,
    student_id        NUMBER,
    section_id        NUMBER,
    enrollment_date   DATE,
    enrollment_status VARCHAR2(20),
    grade             NUMBER(5,2)
);
