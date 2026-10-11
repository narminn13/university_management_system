
-- ============================================================
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 04_indexes.sql
-- Purpose: Improve query performance with useful indexes
-- ============================================================

-- 1. Find students by department
CREATE INDEX idx_students_department
ON students (department_id);

-- 2. Find instructors by department
CREATE INDEX idx_instructors_department
ON instructors (department_id);

-- 3. Find courses by department
CREATE INDEX idx_courses_department
ON courses (department_id);

-- 4. Find course sections by course
CREATE INDEX idx_sections_course
ON course_sections (course_id);

-- 5. Find course sections by semester
CREATE INDEX idx_sections_semester
ON course_sections (semester_id);

-- 6. Find course sections by instructor
CREATE INDEX idx_sections_instructor
ON course_sections (instructor_id);

-- 7. Find enrollments by student
CREATE INDEX idx_enrollments_student
ON enrollments (student_id);

-- 8. Find enrollments by section
CREATE INDEX idx_enrollments_section
ON enrollments (section_id);

-- 9. Find prerequisite relationships by prerequisite course
CREATE INDEX idx_prereq_required_course
ON course_prerequisites (prerequisite_course_id);
