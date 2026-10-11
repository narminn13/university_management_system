
-- ============================================================
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 03_constraints.sql
-- Purpose: Add NOT NULL, UNIQUE and CHECK constraints
-- ============================================================


-- 1. DEPARTMENTS

ALTER TABLE departments
MODIFY (department_name CONSTRAINT nn_departments_name NOT NULL);

ALTER TABLE departments
ADD CONSTRAINT uq_departments_name
UNIQUE (department_name);

ALTER TABLE departments
MODIFY (created_at DEFAULT SYSTIMESTAMP);


-- 2. STUDENTS

ALTER TABLE students
MODIFY (
    first_name     CONSTRAINT nn_students_first_name NOT NULL,
    last_name      CONSTRAINT nn_students_last_name NOT NULL,
    email          CONSTRAINT nn_students_email NOT NULL,
    admission_date CONSTRAINT nn_students_admission_date NOT NULL,
    student_status CONSTRAINT nn_students_status NOT NULL,
    department_id  CONSTRAINT nn_students_department NOT NULL
);

ALTER TABLE students
ADD CONSTRAINT uq_students_email UNIQUE (email);

ALTER TABLE students
ADD CONSTRAINT ck_students_status
CHECK (student_status IN ('ACTIVE', 'SUSPENDED', 'GRADUATED'));


-- 3. INSTRUCTORS

ALTER TABLE instructors
MODIFY (
    first_name   CONSTRAINT nn_instructors_first_name NOT NULL,
    last_name    CONSTRAINT nn_instructors_last_name NOT NULL,
    email        CONSTRAINT nn_instructors_email NOT NULL,
    department_id CONSTRAINT nn_instructors_department NOT NULL
);

ALTER TABLE instructors
ADD CONSTRAINT uq_instructors_email UNIQUE (email);


-- 4. COURSES

ALTER TABLE courses
MODIFY (
    course_code   CONSTRAINT nn_courses_code NOT NULL,
    course_title  CONSTRAINT nn_courses_title NOT NULL,
    credits       CONSTRAINT nn_courses_credits NOT NULL,
    department_id CONSTRAINT nn_courses_department NOT NULL
);

ALTER TABLE courses
ADD CONSTRAINT uq_courses_code UNIQUE (course_code);

ALTER TABLE courses
ADD CONSTRAINT ck_courses_credits
CHECK (credits > 0);


-- 5. COURSE_PREREQUISITES

ALTER TABLE course_prerequisites
MODIFY (
    course_id              CONSTRAINT nn_prereq_course NOT NULL,
    prerequisite_course_id CONSTRAINT nn_prereq_required NOT NULL
);

ALTER TABLE course_prerequisites
ADD CONSTRAINT ck_course_not_own_prerequisite
CHECK (course_id <> prerequisite_course_id);


-- 6. SEMESTERS

ALTER TABLE semesters
MODIFY (
    semester_name CONSTRAINT nn_semesters_name NOT NULL,
    academic_year CONSTRAINT nn_semesters_year NOT NULL,
    start_date    CONSTRAINT nn_semesters_start NOT NULL,
    end_date      CONSTRAINT nn_semesters_end NOT NULL
);

ALTER TABLE semesters
ADD CONSTRAINT ck_semesters_dates
CHECK (end_date > start_date);


-- 7. COURSE_SECTIONS

ALTER TABLE course_sections
MODIFY (
    course_id      CONSTRAINT nn_sections_course NOT NULL,
    semester_id    CONSTRAINT nn_sections_semester NOT NULL,
    instructor_id  CONSTRAINT nn_sections_instructor NOT NULL,
    section_number CONSTRAINT nn_sections_number NOT NULL,
    capacity       CONSTRAINT nn_sections_capacity NOT NULL
);

ALTER TABLE course_sections
ADD CONSTRAINT ck_sections_capacity
CHECK (capacity > 0);

ALTER TABLE course_sections
ADD CONSTRAINT uq_sections_course_semester_number
UNIQUE (course_id, semester_id, section_number);


-- 8. ENROLLMENTS

ALTER TABLE enrollments
MODIFY (
    student_id        CONSTRAINT nn_enrollments_student NOT NULL,
    section_id        CONSTRAINT nn_enrollments_section NOT NULL,
    enrollment_date   CONSTRAINT nn_enrollments_date NOT NULL,
    enrollment_status CONSTRAINT nn_enrollments_status NOT NULL
);

ALTER TABLE enrollments
ADD CONSTRAINT uq_enrollments_student_section
UNIQUE (student_id, section_id);

ALTER TABLE enrollments
ADD CONSTRAINT ck_enrollments_status
CHECK (enrollment_status IN ('ENROLLED', 'COMPLETED', 'WITHDRAWN'));

ALTER TABLE enrollments
ADD CONSTRAINT ck_enrollments_grade
CHECK (grade BETWEEN 0 AND 100 OR grade IS NULL);
