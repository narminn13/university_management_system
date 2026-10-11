
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 05_insert_course_prerequisites.sql

INSERT INTO course_prerequisites (course_id, prerequisite_course_id)
VALUES (2, 1);

INSERT INTO course_prerequisites (course_id, prerequisite_course_id)
VALUES (3, 1);

INSERT INTO course_prerequisites (course_id, prerequisite_course_id)
VALUES (5, 4);

INSERT INTO course_prerequisites (course_id, prerequisite_course_id)
VALUES (6, 4);

INSERT INTO course_prerequisites (course_id, prerequisite_course_id)
VALUES (8, 7);

INSERT INTO course_prerequisites (course_id, prerequisite_course_id)
VALUES (10, 9);

INSERT INTO course_prerequisites (course_id, prerequisite_course_id)
VALUES (12, 11);

COMMIT;

-- Verify inserted prerequisites
SELECT c.course_code AS course_code,
       c.course_title AS course_title,
       p.course_code AS prerequisite_code,
       p.course_title AS prerequisite_title
FROM course_prerequisites cp
JOIN courses c
  ON cp.course_id = c.course_id
JOIN courses p
  ON cp.prerequisite_course_id = p.course_id
ORDER BY c.course_code;
