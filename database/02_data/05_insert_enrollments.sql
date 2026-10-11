
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 05_insert_enrollments.sql

-- Semesters
INSERT ALL
    INTO semesters VALUES (1, 'Fall', '2025-2026', DATE '2025-09-15', DATE '2026-01-15')
    INTO semesters VALUES (2, 'Spring', '2025-2026', DATE '2026-02-15', DATE '2026-06-15')
SELECT 1 FROM dual;

-- Course sections
INSERT ALL
    INTO course_sections VALUES (1, 1, 1, 1, 'A', 30, 'Room 101')
    INTO course_sections VALUES (2, 2, 1, 2, 'A', 25, 'Room 102')
    INTO course_sections VALUES (3, 3, 1, 1, 'A', 25, 'Lab 201')
    INTO course_sections VALUES (4, 4, 1, 3, 'A', 30, 'Room 202')
    INTO course_sections VALUES (5, 5, 1, 4, 'A', 25, 'Lab 301')
    INTO course_sections VALUES (6, 6, 2, 3, 'A', 25, 'Lab 302')
    INTO course_sections VALUES (7, 7, 1, 5, 'A', 30, 'Room 103')
    INTO course_sections VALUES (8, 8, 2, 6, 'A', 30, 'Room 104')
    INTO course_sections VALUES (9, 9, 1, 7, 'A', 35, 'Room 203')
    INTO course_sections VALUES (10, 10, 2, 8, 'A', 30, 'Room 204')
    INTO course_sections VALUES (11, 11, 1, 9, 'A', 25, 'Lab 401')
    INTO course_sections VALUES (12, 12, 2, 10, 'A', 25, 'Room 402')
SELECT 1 FROM dual;

-- Enrollments
INSERT ALL
    INTO enrollments VALUES (1, 1, 4, DATE '2025-09-16', 'COMPLETED', 91)
    INTO enrollments VALUES (2, 2, 1, DATE '2025-09-16', 'COMPLETED', 88)
    INTO enrollments VALUES (3, 3, 7, DATE '2025-09-16', 'COMPLETED', 95)
    INTO enrollments VALUES (4, 4, 2, DATE '2025-09-16', 'COMPLETED', 79)
    INTO enrollments VALUES (5, 5, 5, DATE '2025-09-16', 'COMPLETED', 93)
    INTO enrollments VALUES (6, 6, 11, DATE '2025-09-16', 'COMPLETED', 84)
    INTO enrollments VALUES (7, 7, 9, DATE '2025-09-16', 'COMPLETED', 90)
    INTO enrollments VALUES (8, 8, 8, DATE '2026-02-16', 'ENROLLED', NULL)
    INTO enrollments VALUES (9, 9, 6, DATE '2026-02-16', 'ENROLLED', NULL)
    INTO enrollments VALUES (10, 10, 12, DATE '2026-02-16', 'ENROLLED', NULL)
    INTO enrollments VALUES (11, 11, 3, DATE '2025-09-16', 'COMPLETED', 86)
    INTO enrollments VALUES (12, 12, 10, DATE '2026-02-16', 'ENROLLED', NULL)
    INTO enrollments VALUES (13, 13, 7, DATE '2025-09-16', 'COMPLETED', 89)
    INTO enrollments VALUES (14, 14, 11, DATE '2025-09-16', 'COMPLETED', 82)
    INTO enrollments VALUES (15, 15, 4, DATE '2025-09-16', 'COMPLETED', 96)
    INTO enrollments VALUES (16, 16, 1, DATE '2025-09-16', 'COMPLETED', 77)
    INTO enrollments VALUES (17, 17, 9, DATE '2025-09-16', 'COMPLETED', 85)
    INTO enrollments VALUES (18, 18, 8, DATE '2026-02-16', 'ENROLLED', NULL)
    INTO enrollments VALUES (19, 19, 12, DATE '2026-02-16', 'ENROLLED', NULL)
    INTO enrollments VALUES (20, 20, 6, DATE '2026-02-16', 'ENROLLED', NULL)
SELECT 1 FROM dual;

COMMIT;
