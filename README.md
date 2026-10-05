# RDBMS Autograding – Student Table Normalization up to 3NF

## Question

Consider a Student table with the following fields:

- StudentID
- StudentName
- CourseName
- FacultyName
- DepartmentName

Normalize the table up to Third Normal Form (3NF).

## Original Relation

```text
Student(
    StudentID,
    StudentName,
    CourseName,
    FacultyName,
    DepartmentName
)
Student(
    StudentID,
    StudentName,
    CourseName,
    FacultyName,
    DepartmentName
)

Student(
    StudentID,
    StudentName,
    DepartmentID
)

Course(
    CourseID,
    CourseName,
    FacultyID
)

Faculty(
    FacultyID,
    FacultyName,
    DepartmentID
)

Department(
    DepartmentID,
    DepartmentName
)

Enrollment(
    StudentID,
    CourseID
)
Department(DepartmentID, DepartmentName)

Faculty(FacultyID, FacultyName, DepartmentID)

Course(CourseID, CourseName, FacultyID)

Student(StudentID, StudentName, DepartmentID)

Enrollment(StudentID, CourseID)

Department 1 ─────── N Student

Department 1 ─────── N Faculty

Faculty 1 ─────────── N Course

Student M ─────── N Course
        through Enrollment
