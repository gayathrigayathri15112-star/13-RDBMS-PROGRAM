USE CollegeDB;


-- ==========================================
-- TEST 1: Check required 3NF tables
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) = 5
        THEN 'PASS: All 5 normalized tables exist'
        ELSE 'FAIL: Required 3NF tables are missing'
    END AS TestResult
FROM information_schema.tables
WHERE table_schema = 'CollegeDB'
AND table_name IN
(
    'Student',
    'Course',
    'Faculty',
    'Department',
    'Enrollment'
);


-- ==========================================
-- TEST 2: Student Primary Key
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) = 1
        THEN 'PASS: StudentID is Primary Key'
        ELSE 'FAIL: StudentID Primary Key missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Student'
AND column_name = 'StudentID'
AND constraint_name = 'PRIMARY';


-- ==========================================
-- TEST 3: Course Primary Key
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) = 1
        THEN 'PASS: CourseID is Primary Key'
        ELSE 'FAIL: CourseID Primary Key missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Course'
AND column_name = 'CourseID'
AND constraint_name = 'PRIMARY';


-- ==========================================
-- TEST 4: Faculty Primary Key
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) = 1
        THEN 'PASS: FacultyID is Primary Key'
        ELSE 'FAIL: FacultyID Primary Key missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Faculty'
AND column_name = 'FacultyID'
AND constraint_name = 'PRIMARY';


-- ==========================================
-- TEST 5: Department Primary Key
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) = 1
        THEN 'PASS: DepartmentID is Primary Key'
        ELSE 'FAIL: DepartmentID Primary Key missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Department'
AND column_name = 'DepartmentID'
AND constraint_name = 'PRIMARY';


-- ==========================================
-- TEST 6: Enrollment Composite Primary Key
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) = 2
        THEN 'PASS: Enrollment has composite Primary Key'
        ELSE 'FAIL: Enrollment composite Primary Key missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Enrollment'
AND constraint_name = 'PRIMARY';


-- ==========================================
-- TEST 7: Student -> Department FK
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Student references Department'
        ELSE 'FAIL: Student-Department relationship missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Student'
AND column_name = 'DepartmentID'
AND referenced_table_name = 'Department'
AND referenced_column_name = 'DepartmentID';


-- ==========================================
-- TEST 8: Faculty -> Department FK
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Faculty references Department'
        ELSE 'FAIL: Faculty-Department relationship missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Faculty'
AND column_name = 'DepartmentID'
AND referenced_table_name = 'Department'
AND referenced_column_name = 'DepartmentID';


-- ==========================================
-- TEST 9: Course -> Faculty FK
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Course references Faculty'
        ELSE 'FAIL: Course-Faculty relationship missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Course'
AND column_name = 'FacultyID'
AND referenced_table_name = 'Faculty'
AND referenced_column_name = 'FacultyID';


-- ==========================================
-- TEST 10: Enrollment -> Student FK
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Enrollment references Student'
        ELSE 'FAIL: Enrollment-Student relationship missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Enrollment'
AND column_name = 'StudentID'
AND referenced_table_name = 'Student'
AND referenced_column_name = 'StudentID';


-- ==========================================
-- TEST 11: Enrollment -> Course FK
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Enrollment references Course'
        ELSE 'FAIL: Enrollment-Course relationship missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Enrollment'
AND column_name = 'CourseID'
AND referenced_table_name = 'Course'
AND referenced_column_name = 'CourseID';


-- ==========================================
-- TEST 12: Check sample data
-- ==========================================

SELECT
    CASE
        WHEN
            (SELECT COUNT(*) FROM Department) >= 3
            AND
            (SELECT COUNT(*) FROM Faculty) >= 3
            AND
            (SELECT COUNT(*) FROM Student) >= 4
            AND
            (SELECT COUNT(*) FROM Course) >= 4
            AND
            (SELECT COUNT(*) FROM Enrollment) >= 6
        THEN 'PASS: Sample data exists'
        ELSE 'FAIL: Sample data is incomplete'
    END AS TestResult;


-- ==========================================
-- TEST 13: Check Student data
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) = 1
        THEN 'PASS: Arun belongs to Computer Science'
        ELSE 'FAIL: Student normalization/data incorrect'
    END AS TestResult
FROM Student s
JOIN Department d
    ON s.DepartmentID = d.DepartmentID
WHERE s.StudentName = 'Arun'
AND d.DepartmentName = 'Computer Science';


-- ==========================================
-- TEST 14: Check final normalized output
-- ==========================================

SELECT
    CASE
        WHEN COUNT(*) >= 6
        THEN 'PASS: Normalized tables produce correct joined data'
        ELSE 'FAIL: Normalized data cannot be joined correctly'
    END AS TestResult
FROM Student s
JOIN Enrollment e
    ON s.StudentID = e.StudentID
JOIN Course c
    ON e.CourseID = c.CourseID
JOIN Faculty f
    ON c.FacultyID = f.FacultyID
JOIN Department d
    ON s.DepartmentID = d.DepartmentID;
