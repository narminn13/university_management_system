
-- ============================================================
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 02_primary_foreign_keys.sql
-- Purpose: Add primary keys and foreign keys
-- ============================================================


-- 1. DEPARTMENTS
ALTER TABLE departments
ADD CONSTRAINT pk_departments
PRIMARY KEY (department_id);


-- 2. STUDENTS
ALTER TABLE students
ADD CONSTRAINT pk_students
PRIMARY KEY (student_id);

ALTER TABLE students
ADD CONSTRAINT fk_students_departments
FOREIGN KEY (department_id)
REFERENCES departments(department_id);


-- 3. INSTRUCTORS
ALTER TABLE instructors
ADD CONSTRAINT pk_instructors
PRIMARY KEY (instructor_id);

ALTER TABLE instructors
ADD CONSTRAINT fk_instructors_departments
FOREIGN KEY (department_id)
REFERENCES departments(department_id);


-- 4. COURSES
ALTER TABLE courses
ADD CONSTRAINT pk_courses
PRIMARY KEY (course_id);

ALTER TABLE courses
ADD CONSTRAINT fk_courses_departments
FOREIGN KEY (department_id)
REFERENCES departments(department_id);


-- 5. COURSE_PREREQUISITES
ALTER TABLE course_prerequisites
ADD CONSTRAINT pk_course_prerequisites
PRIMARY KEY (course_id, prerequisite_course_id);

ALTER TABLE course_prerequisites
ADD CONSTRAINT fk_prerequisites_course
FOREIGN KEY (course_id)
REFERENCES courses(course_id);

ALTER TABLE course_prerequisites
ADD CONSTRAINT fk_prerequisites_required
FOREIGN KEY (prerequisite_course_id)
REFERENCES courses(course_id);


-- 6. SEMESTERS
ALTER TABLE semesters
ADD CONSTRAINT pk_semesters
PRIMARY KEY (semester_id);


-- 7. COURSE_SECTIONS
ALTER TABLE course_sections
ADD CONSTRAINT pk_course_sections
PRIMARY KEY (section_id);

ALTER TABLE course_sections
ADD CONSTRAINT fk_sections_courses
FOREIGN KEY (course_id)
REFERENCES courses(course_id);

ALTER TABLE course_sections
ADD CONSTRAINT fk_sections_semesters
FOREIGN KEY (semester_id)
REFERENCES semesters(semester_id);

ALTER TABLE course_sections
ADD CONSTRAINT fk_sections_instructors
FOREIGN KEY (instructor_id)
REFERENCES instructors(instructor_id);


-- 8. ENROLLMENTS
ALTER TABLE enrollments
ADD CONSTRAINT pk_enrollments
PRIMARY KEY (enrollment_id);

ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollments_students
FOREIGN KEY (student_id)
REFERENCES students(student_id);

ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollments_sections
FOREIGN KEY (section_id)
REFERENCES course_sections(section_id);
