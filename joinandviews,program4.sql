-- =========================================================
-- MOVIE STREAMING DATABASE SYSTEM
-- JOIN OPERATIONS AND VIEWS
-- =========================================================

-- =========================================================
-- CREATE DATABASE
-- =========================================================

CREATE DATABASE MovieStreamingDB;

USE MovieStreamingDB;

-- =========================================================
-- CREATE TABLES
-- =========================================================

CREATE TABLE Users (
    User_ID INT PRIMARY KEY,
    User_Name VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Movies (
    Movie_ID INT PRIMARY KEY,
    Movie_Name VARCHAR(100),
    Genre VARCHAR(50),
    Release_Year INT
);

CREATE TABLE Subscriptions (
    Subscription_ID INT PRIMARY KEY,
    User_ID INT,
    Plan_Name VARCHAR(50),
    Amount DECIMAL(10,2),

    FOREIGN KEY (User_ID)
    REFERENCES Users(User_ID)
);

CREATE TABLE Watch_History (
    Watch_ID INT PRIMARY KEY,
    User_ID INT,
    Movie_ID INT,
    Watch_Date DATE,

    FOREIGN KEY (User_ID)
    REFERENCES Users(User_ID),

    FOREIGN KEY (Movie_ID)
    REFERENCES Movies(Movie_ID)
);

-- =========================================================
-- INSERT DATA INTO Users
-- =========================================================

INSERT INTO Users VALUES
(1, 'Aman', 'Pune'),
(2, 'Sneha', 'Mumbai'),
(3, 'Rahul', 'Delhi'),
(4, 'Riya', 'Bangalore');

-- =========================================================
-- INSERT DATA INTO Movies
-- =========================================================

INSERT INTO Movies VALUES
(101, 'Inception', 'Sci-Fi', 2010),
(102, 'Avengers Endgame', 'Action', 2019),
(103, '3 Idiots', 'Comedy', 2009),
(104, 'Interstellar', 'Sci-Fi', 2014);

-- =========================================================
-- INSERT DATA INTO Subscriptions
-- =========================================================

INSERT INTO Subscriptions VALUES
(201, 1, 'Premium', 799),
(202, 2, 'Basic', 299),
(203, 3, 'Standard', 499);

-- =========================================================
-- INSERT DATA INTO Watch_History
-- =========================================================

INSERT INTO Watch_History VALUES
(1, 1, 101, '2025-05-01'),
(2, 1, 104, '2025-05-03'),
(3, 2, 102, '2025-05-02'),
(4, 3, 103, '2025-05-04');

-- =========================================================
-- DISPLAY TABLES
-- =========================================================

SELECT * FROM Users;
SELECT * FROM Movies;
SELECT * FROM Subscriptions;
SELECT * FROM Watch_History;

-- =========================================================
-- INNER JOIN
-- Display users with their subscription plans
-- =========================================================

SELECT U.User_Name,
       S.Plan_Name,
       S.Amount
FROM Users U
INNER JOIN Subscriptions S
ON U.User_ID = S.User_ID;

-- =========================================================
-- INNER JOIN
-- Display users and watched movies
-- =========================================================

SELECT U.User_Name,
       M.Movie_Name,
       WH.Watch_Date
FROM Watch_History WH
INNER JOIN Users U
ON WH.User_ID = U.User_ID
INNER JOIN Movies M
ON WH.Movie_ID = M.Movie_ID;

-- =========================================================
-- LEFT JOIN
-- Show all users and their subscriptions
-- =========================================================

SELECT U.User_Name,
       S.Plan_Name
FROM Users U
LEFT JOIN Subscriptions S
ON U.User_ID = S.User_ID;

-- =========================================================
-- RIGHT JOIN
-- Show all subscriptions and related users
-- =========================================================

SELECT U.User_Name,
       S.Plan_Name
FROM Users U
RIGHT JOIN Subscriptions S
ON U.User_ID = S.User_ID;

-- =========================================================
-- CROSS JOIN
-- Generate all possible user-movie combinations
-- =========================================================

SELECT U.User_Name,
       M.Movie_Name
FROM Users U
CROSS JOIN Movies M;

-- =========================================================
-- SELF JOIN
-- Compare users from same city
-- =========================================================

SELECT A.User_Name AS User1,
       B.User_Name AS User2,
       A.City
FROM Users A
JOIN Users B
ON A.City = B.City
AND A.User_ID <> B.User_ID;

-- =========================================================
-- CREATE VIEW
-- Frequently watched movie details
-- =========================================================

CREATE VIEW User_Watch_Details AS
SELECT U.User_Name,
       M.Movie_Name,
       M.Genre,
       WH.Watch_Date
FROM Watch_History WH
JOIN Users U
ON WH.User_ID = U.User_ID
JOIN Movies M
ON WH.Movie_ID = M.Movie_ID;

-- =========================================================
-- DISPLAY VIEW
-- =========================================================

SELECT * FROM User_Watch_Details;

-- =========================================================
-- CREATE VIEW
-- Subscription summary
-- =========================================================

CREATE VIEW Subscription_Summary AS
SELECT U.User_Name,
       S.Plan_Name,
       S.Amount
FROM Users U
JOIN Subscriptions S
ON U.User_ID = S.User_ID;

-- =========================================================
-- DISPLAY VIEW
-- =========================================================

SELECT * FROM Subscription_Summary;

-- =========================================================
-- UPDATE VIEW DATA
-- =========================================================

UPDATE Subscription_Summary
SET Amount = 899
WHERE User_Name = 'Aman';

-- =========================================================
-- DROP VIEW
-- =========================================================

DROP VIEW Subscription_Summary;