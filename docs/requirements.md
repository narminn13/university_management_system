# University Management System

## 1. Project Overview

The University Management System is a relational database project designed to manage university students, instructors, departments, courses, semesters, and student enrollments.

The project uses Oracle SQL and PL/SQL to demonstrate database design, data integrity, complex queries, stored procedures, functions, triggers, and transaction management.

## 2. Project Objectives

- Design a normalized relational database.
- Maintain accurate student and instructor records.
- Organize departments and courses.
- Manage course offerings and student enrollments.
- Record student grades and calculate academic performance.
- Generate academic and administrative reports.
- Implement business rules using SQL and PL/SQL.

## 3. Core Entities

- Departments
- Students
- Instructors
- Courses
- Semesters
- Course Sections
- Enrollments

## 4. Main Functional Requirements

### Student Management
- Store student information and unique student IDs.
- Associate students with academic departments.
- Track student enrollment status.

### Instructor Management
- Store instructor information.
- Associate instructors with departments.
- Assign instructors to course sections.

### Course Management
- Store course codes, titles, credits, and departments.
- Define course prerequisites where applicable.
- Offer courses during specific semesters.

### Enrollment Management
- Register students for course sections.
- Prevent duplicate enrollment in the same section.
- Store grades and enrollment status.
- Maintain enrollment capacity limits.

### Academic Reporting
- View students enrolled in each course section.
- Calculate student GPA based on recorded grades and course credits.
- Summarize course enrollment numbers.
- Report instructor teaching workloads.

## 5. Database Requirements

- Use primary keys and foreign keys.
- Apply appropriate NOT NULL, UNIQUE, and CHECK constraints.
- Maintain referential integrity.
- Follow relational database normalization principles.
- Use transactions for operations that modify related records.
- Implement selected business rules using PL/SQL.

## 6. Technology Stack

- Database: Oracle Database
- Query Language: SQL
- Procedural Language: PL/SQL
- ERD Design: diagrams.net (draw.io)
- Version Control