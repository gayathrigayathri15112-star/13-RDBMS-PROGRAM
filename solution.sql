USE CollegeDB;

-- Remove existing tables
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Faculty;
DROP TABLE IF EXISTS Department;


-- ==========================================
-- 3NF TABLE 1: Department
-- ==========================================

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);


-- ==========================================
-- 3NF TABLE 2: Faculty
-- ==========================================

CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    FacultyName VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,

    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);


-- ==========================================
-- 3NF TABLE 3: Course
-- ==========================================

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    FacultyID INT NOT NULL,

    FOREIGN KEY (FacultyID)
        REFERENCES Faculty(FacultyID)
);


-- ==========================================
-- 3NF TABLE 4: Student
-- ==========================================

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,

    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);


-- ==========================================
-- 3NF TABLE 5: Enrollment
-- Resolves Student-Course M:N relationship
-- ==========================================

CREATE TABLE Enrollment (
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,

    PRIMARY KEY (StudentID, CourseID),

    FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),

    FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID)
);


-- ==========================================
-- SAMPLE DATA
-- ==========================================

INSERT INTO Department
(DepartmentID, DepartmentName)
VALUES
(101, 'Computer Science'),
(102, 'Information Technology'),
(103, 'Electronics');


INSERT INTO Faculty
(FacultyID, FacultyName, DepartmentID)
VALUES
(501, 'Dr. Kumar', 101),
(502, 'Dr. Priya', 102),
(503, 'Dr. Ravi', 103);


INSERT INTO Student
(StudentID, StudentName, DepartmentID)
VALUES
(1001, 'Arun', 101),
(1002, 'Divya', 102),
(1003, 'Karthik', 101),
(1004, 'Nisha', 103);


INSERT INTO Course
(CourseID, CourseName, FacultyID)
VALUES
(201, 'Database Systems', 501),
(202, 'Python Programming', 502),
(203, 'Operating Systems', 501),
(204, 'Computer Networks', 503);


INSERT INTO Enrollment
(StudentID, CourseID)
VALUES
(1001, 201),
(1001, 203),
(1002, 202),
(1003, 201),
(1003, 203),
(1004, 204);


-- ==========================================
-- DISPLAY FINAL 3NF DATA
-- ==========================================

SELECT
    s.StudentID,
    s.StudentName,
    c.CourseName,
    f.FacultyName,
    d.DepartmentName
FROM Student s
JOIN Department d
    ON s.DepartmentID = d.DepartmentID
JOIN Enrollment e
    ON s.StudentID = e.StudentID
JOIN Course c
    ON e.CourseID = c.CourseID
JOIN Faculty f
    ON c.FacultyID = f.FacultyID
ORDER BY s.StudentID, c.CourseID;
