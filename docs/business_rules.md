# Business Rules — University Management System

## 1. Departments
- Each department must have a unique department ID.
- Each department must have a unique name.
- A department can have multiple students, instructors, and courses.
- Each student, instructor, and course belongs to one department.

## 2. Students
- Each student must have a unique student ID.
- Each student must have a unique email address.
- Each student belongs to one department.
- A student can enroll in multiple course sections.
- A student's enrollment status can be Active, Suspended, or Graduated.

## 3. Instructors
- Each instructor must have a unique instructor ID.
- Each instructor must have a unique email address.
- Each instructor belongs to one department.
- An instructor can teach multiple course sections.

## 4. Courses
- Each course must have a unique course code.
- Each course belongs to one department.
- Each course has a defined credit value.
- A course can have multiple course sections.
- A course may require completion of prerequisite courses.

## 5. Semesters
- Each semester must have a unique semester ID.
- Each semester has a name, start date, and end date.
- The end date must be later than the start date.
- A semester can contain multiple course sections.

## 6. Course Sections
- Each course section represents a specific offering of a course in a semester.
- Each section belongs to one course and one semester.
- Each section is assigned one instructor.
- Each section has a maximum enrollment capacity.
- The number of enrolled students cannot exceed the section capacity.

## 7. Enrollments
- Each enrollment links one student to one course section.
- A student cannot enroll in the same course section more than once.
- An enrollment has a status: Enrolled, Completed, or Withdraw