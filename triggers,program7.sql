-- =========================================================
-- ONLINE COURSE ENROLLMENT SYSTEM
-- DATABASE TRIGGERS
-- =========================================================

-- =========================================================
-- CREATE DATABASE
-- =========================================================

CREATE DATABASE CourseEnrollmentDB;

USE CourseEnrollmentDB;

-- =========================================================
-- CREATE TABLES
-- =========================================================

CREATE TABLE Students (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100),
    Fees DECIMAL(10,2),
    Available_Seats INT
);

CREATE TABLE Enrollments (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE,

    FOREIGN KEY (Student_ID)
    REFERENCES Students(Student_ID),

    FOREIGN KEY (Course_ID)
    REFERENCES Courses(Course_ID)
);

-- =========================================================
-- LOG TABLE
-- =========================================================

CREATE TABLE Enrollment_Log (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Action_Type VARCHAR(20),
    Message VARCHAR(255),
    Action_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- INSERT SAMPLE DATA
-- =========================================================

INSERT INTO Students VALUES
(1, 'Aman', 'aman@gmail.com'),
(2, 'Sneha', 'sneha@gmail.com');

INSERT INTO Courses VALUES
(101, 'SQL Programming', 5000, 2),
(102, 'Python Development', 7000, 1);

-- =========================================================
-- TRIGGER 1
-- PREVENT INVALID DATA ENTRY
-- Course fees cannot be negative
-- =========================================================

DELIMITER $$

CREATE TRIGGER Check_Course_Fees
BEFORE INSERT
ON Courses
FOR EACH ROW

BEGIN

    IF NEW.Fees < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Course fees cannot be negative';
    END IF;

END $$

DELIMITER ;

-- =========================================================
-- TRIGGER 2
-- PREVENT ENROLLMENT IF NO SEATS AVAILABLE
-- =========================================================

DELIMITER $$

CREATE TRIGGER Check_Available_Seats
BEFORE INSERT
ON Enrollments
FOR EACH ROW

BEGIN

    DECLARE seats INT;

    SELECT Available_Seats
    INTO seats
    FROM Courses
    WHERE Course_ID = NEW.Course_ID;

    IF seats <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No seats available for this course';
    END IF;

END $$

DELIMITER ;

-- =========================================================
-- TRIGGER 3
-- MAINTAIN CONSISTENCY
-- Reduce available seats after enrollment
-- =========================================================

DELIMITER $$

CREATE TRIGGER Reduce_Seats_After_Enrollment
AFTER INSERT
ON Enrollments
FOR EACH ROW

BEGIN

    UPDATE Courses
    SET Available_Seats = Available_Seats - 1
    WHERE Course_ID = NEW.Course_ID;

END $$

DELIMITER ;

-- =========================================================
-- TRIGGER 4
-- LOG ENROLLMENT INSERT
-- =========================================================

DELIMITER $$

CREATE TRIGGER Log_Enrollment_Insert
AFTER INSERT
ON Enrollments
FOR EACH ROW

BEGIN

    INSERT INTO Enrollment_Log(Action_Type, Message)
    VALUES
    (
        'INSERT',
        CONCAT('Student ', NEW.Student_ID,
        ' enrolled in Course ', NEW.Course_ID)
    );

END $$

DELIMITER ;

-- =========================================================
-- TRIGGER 5
-- LOG COURSE UPDATE
-- =========================================================

DELIMITER $$

CREATE TRIGGER Log_Course_Update
AFTER UPDATE
ON Courses
FOR EACH ROW

BEGIN

    INSERT INTO Enrollment_Log(Action_Type, Message)
    VALUES
    (
        'UPDATE',
        CONCAT('Course ', OLD.Course_Name,
        ' updated. Old Fees: ', OLD.Fees,
        ', New Fees: ', NEW.Fees)
    );

END $$

DELIMITER ;

-- =========================================================
-- TRIGGER 6
-- LOG ENROLLMENT DELETE
-- =========================================================

DELIMITER $$

CREATE TRIGGER Log_Enrollment_Delete
AFTER DELETE
ON Enrollments
FOR EACH ROW

BEGIN

    INSERT INTO Enrollment_Log(Action_Type, Message)
    VALUES
    (
        'DELETE',
        CONCAT('Enrollment deleted for Student ',
        OLD.Student_ID,
        ' from Course ',
        OLD.Course_ID)
    );

END $$

DELIMITER ;

-- =========================================================
-- TRIGGER 7
-- INCREASE SEATS AFTER ENROLLMENT DELETE
-- =========================================================

DELIMITER $$

CREATE TRIGGER Increase_Seats_After_Delete
AFTER DELETE
ON Enrollments
FOR EACH ROW

BEGIN

    UPDATE Courses
    SET Available_Seats = Available_Seats + 1
    WHERE Course_ID = OLD.Course_ID;

END $$

DELIMITER ;

-- =========================================================
-- TESTING TRIGGERS
-- =========================================================

-- Valid Enrollment
INSERT INTO Enrollments VALUES
(1, 1, 101, '2025-05-01');

-- Another Enrollment
INSERT INTO Enrollments VALUES
(2, 2, 101, '2025-05-02');

-- This will fail because seats become 0
-- INSERT INTO Enrollments VALUES
-- (3, 1, 101, '2025-05-03');

-- Update Course Fees
UPDATE Courses
SET Fees = 5500
WHERE Course_ID = 101;

-- Delete Enrollment
DELETE FROM Enrollments
WHERE Enrollment_ID = 2;

-- =========================================================
-- DISPLAY TABLES
-- =========================================================

SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
SELECT * FROM Enrollment_Log;