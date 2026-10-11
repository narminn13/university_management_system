
-- UNIVERSITY MANAGEMENT SYSTEM
-- File: 06_triggers.sql

CREATE OR REPLACE TRIGGER trg_enrollment_rules
BEFORE INSERT OR UPDATE OF enrollment_status, grade
ON enrollments
FOR EACH ROW
BEGIN
    -- Automatically set the enrollment date for new records
    IF INSERTING AND :NEW.enrollment_date IS NULL THEN
        :NEW.enrollment_date := SYSDATE;
    END IF;

    -- An enrolled student should not have a final grade yet
    IF :NEW.enrollment_status = 'ENROLLED'
       AND :NEW.grade IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(
            -20010,
            'An enrolled student cannot have a final grade.'
        );
    END IF;

    -- Withdrawn enrollments should not retain a grade
    IF :NEW.enrollment_status = 'WITHDRAWN' THEN
        :NEW.grade := NULL;
    END IF;
END;
/

-- Verify that the trigger was created successfully
SELECT trigger_name,
       triggering_event,
       status
FROM user_triggers
WHERE trigger_name = 'TRG_ENROLLMENT_RULES';

-- Test the existing enrollment data
SELECT enrollment_id,
       enrollment_status,
       enrollment_date,
       grade
FROM enrollments
ORDER BY enrollment_id;
