-- =====================================================
-- LIBRARY MANAGEMENT SYSTEM
-- SQL DDL Commands Demonstration
-- CREATE, ALTER, DROP, RENAME, TRUNCATE
-- Constraints: PRIMARY KEY, FOREIGN KEY,
-- NOT NULL, UNIQUE, CHECK
-- =====================================================

-- Step 1: Create Database
CREATE DATABASE LibraryDB;

-- Step 2: Use Database
USE LibraryDB;

-- =====================================================
-- CREATE TABLE : Librarian
-- =====================================================

CREATE TABLE Librarian (
    Librarian_ID INT PRIMARY KEY,
    Librarian_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE
);

-- =====================================================
-- CREATE TABLE : Books
-- =====================================================

CREATE TABLE Books (
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Price DECIMAL(8,2) CHECK (Price > 0),
    Quantity INT CHECK (Quantity >= 0)
);

-- =====================================================
-- CREATE TABLE : Members
-- =====================================================

CREATE TABLE Members (
    Member_ID INT PRIMARY KEY,
    Member_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) UNIQUE,
    City VARCHAR(50)
);

-- =====================================================
-- CREATE TABLE : Issue_Book
-- =====================================================

CREATE TABLE Issue_Book (
    Issue_ID INT PRIMARY KEY,
    Member_ID INT,
    Book_ID INT,
    Issue_Date DATE,
    
    FOREIGN KEY (Member_ID)
    REFERENCES Members(Member_ID),
    
    FOREIGN KEY (Book_ID)
    REFERENCES Books(Book_ID)
);

-- =====================================================
-- INSERT DATA INTO Librarian
-- =====================================================

INSERT INTO Librarian VALUES
(1, 'Atul Hooda', 'atul@library.com'),
(2, 'Rahul Sharma', 'rahul@library.com');

-- =====================================================
-- INSERT DATA INTO Books
-- =====================================================

INSERT INTO Books VALUES
(101, 'Database Management System', 'Korth', 550.00, 10),
(102, 'Operating Systems', 'Galvin', 650.00, 5),
(103, 'Computer Networks', 'Tanenbaum', 700.00, 8);

-- =====================================================
-- INSERT DATA INTO Members
-- =====================================================

INSERT INTO Members VALUES
(201, 'Aman', '9876543210', 'Pune'),
(202, 'Sneha', '9876501234', 'Mumbai'),
(203, 'Riya', '9876512345', 'Delhi');

-- =====================================================
-- INSERT DATA INTO Issue_Book
-- =====================================================

INSERT INTO Issue_Book VALUES
(1, 201, 101, '2025-05-01'),
(2, 202, 102, '2025-05-03');

-- =====================================================
-- DISPLAY TABLES
-- =====================================================

SELECT * FROM Librarian;
SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM Issue_Book;

-- =====================================================
-- ALTER TABLE
-- Add new column in Books table
-- =====================================================

ALTER TABLE Books
ADD Publisher VARCHAR(100);

-- =====================================================
-- UPDATE NEW COLUMN VALUES
-- =====================================================

UPDATE Books
SET Publisher = 'Pearson'
WHERE Book_ID = 101;

-- =====================================================
-- RENAME TABLE
-- =====================================================

RENAME TABLE Members TO Library_Members;

-- =====================================================
-- DISPLAY RENAMED TABLE
-- =====================================================

SELECT * FROM Library_Members;

-- =====================================================
-- TRUNCATE TABLE
-- Deletes all records only
-- =====================================================

TRUNCATE TABLE Issue_Book;

-- =====================================================
-- DROP TABLE
-- =====================================================

DROP TABLE Librarian;

-- =====================================================
-- OPTIONAL : DROP DATABASE
-- =====================================================

-- DROP DATABASE LibraryDB;