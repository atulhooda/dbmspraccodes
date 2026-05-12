-- =========================================================
-- HOSPITAL MANAGEMENT SYSTEM
-- DML, DCL, and TCL Commands Demonstration
-- =========================================================

-- =========================================================
-- CREATE DATABASE
-- =========================================================

CREATE DATABASE HospitalDB;

USE HospitalDB;

-- =========================================================
-- CREATE TABLES
-- =========================================================

CREATE TABLE Doctors (
    Doctor_ID INT PRIMARY KEY,
    Doctor_Name VARCHAR(100),
    Specialization VARCHAR(100),
    Salary DECIMAL(10,2)
);

CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100),
    Age INT,
    Disease VARCHAR(100),
    City VARCHAR(50),
    Doctor_ID INT,
    
    FOREIGN KEY (Doctor_ID)
    REFERENCES Doctors(Doctor_ID)
);

-- =========================================================
-- INSERT RECORDS (DML)
-- =========================================================

INSERT INTO Doctors VALUES
(1, 'Dr. Sharma', 'Cardiologist', 90000),
(2, 'Dr. Mehta', 'Neurologist', 85000),
(3, 'Dr. Rao', 'Orthopedic', 75000);

INSERT INTO Patients VALUES
(101, 'Aman', 22, 'Heart Problem', 'Pune', 1),
(102, 'Sneha', 25, 'Migraine', 'Mumbai', 2),
(103, 'Riya', 19, 'Fracture', 'Delhi', 3);

-- =========================================================
-- DISPLAY DATA
-- =========================================================

SELECT * FROM Doctors;
SELECT * FROM Patients;

-- =========================================================
-- UPDATE RECORDS (DML)
-- =========================================================

UPDATE Patients
SET Disease = 'Severe Migraine'
WHERE Patient_ID = 102;

-- =========================================================
-- DELETE RECORDS (DML)
-- =========================================================

DELETE FROM Patients
WHERE Patient_ID = 103;

-- =========================================================
-- ARITHMETIC OPERATORS
-- =========================================================

SELECT Doctor_Name, Salary, Salary + 5000 AS Increased_Salary
FROM Doctors;

-- =========================================================
-- LOGICAL OPERATORS
-- =========================================================

SELECT *
FROM Patients
WHERE Age > 20 AND City = 'Pune';

-- =========================================================
-- SET OPERATORS
-- UNION
-- =========================================================

SELECT Doctor_Name AS Name
FROM Doctors

UNION

SELECT Patient_Name AS Name
FROM Patients;

-- =========================================================
-- PATTERN MATCHING
-- =========================================================

SELECT *
FROM Doctors
WHERE Doctor_Name LIKE 'Dr.%';

-- =========================================================
-- STRING FUNCTIONS
-- =========================================================

SELECT 
    UPPER(Doctor_Name) AS Doctor_Name_Upper,
    LENGTH(Doctor_Name) AS Name_Length
FROM Doctors;

-- =========================================================
-- DCL COMMANDS
-- GRANT, REVOKE, ROLE
-- =========================================================

-- Create User
CREATE USER 'hospital_user'@'localhost'
IDENTIFIED BY 'hospital123';

-- Create Role
CREATE ROLE receptionist;

-- Grant Permissions to Role
GRANT SELECT, INSERT
ON HospitalDB.Patients
TO receptionist;

-- Assign Role to User
GRANT receptionist
TO 'hospital_user'@'localhost';

-- Revoke Permission
REVOKE INSERT
ON HospitalDB.Patients
FROM receptionist;

-- =========================================================
-- TCL COMMANDS
-- START TRANSACTION, SAVEPOINT,
-- COMMIT, ROLLBACK
-- =========================================================

START TRANSACTION;

INSERT INTO Patients VALUES
(104, 'Karan', 30, 'Fever', 'Nagpur', 1);

SAVEPOINT sp1;

UPDATE Doctors
SET Salary = Salary + 10000
WHERE Doctor_ID = 1;

-- Rollback to Savepoint
ROLLBACK TO sp1;

-- Commit Transaction
COMMIT;

-- =========================================================
-- FINAL DISPLAY
-- =========================================================

SELECT * FROM Doctors;
SELECT * FROM Patients;