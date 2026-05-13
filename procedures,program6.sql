-- =========================================================
-- LIBRARY MANAGEMENT SYSTEM
-- STORED PROCEDURES / FUNCTIONS USING CURSORS
-- =========================================================

-- =========================================================
-- CREATE DATABASE
-- =========================================================

CREATE DATABASE LibraryDB;

USE LibraryDB;

-- =========================================================
-- CREATE TABLE
-- =========================================================

CREATE TABLE Books (
    Book_ID INT PRIMARY KEY,
    Book_Name VARCHAR(100),
    Author VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

-- =========================================================
-- INSERT RECORDS
-- =========================================================

INSERT INTO Books VALUES
(101, 'Database Management System', 'Korth', 'Education', 650),
(102, 'Operating Systems', 'Galvin', 'Education', 550),
(103, 'Harry Potter', 'J.K. Rowling', 'Fiction', 450),
(104, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 'Finance', 700),
(105, 'Computer Networks', 'Tanenbaum', 'Education', 600);

-- =========================================================
-- DISPLAY TABLE
-- =========================================================

SELECT * FROM Books;

-- =========================================================
-- PROCEDURE 1
-- DISPLAY BOOK DETAILS USING CURSOR
-- =========================================================

DELIMITER $$

CREATE PROCEDURE Display_Book_Details()
BEGIN

    DECLARE done INT DEFAULT 0;

    DECLARE b_id INT;
    DECLARE b_name VARCHAR(100);
    DECLARE b_author VARCHAR(100);
    DECLARE b_category VARCHAR(50);
    DECLARE b_price DECIMAL(10,2);

    DECLARE book_cursor CURSOR FOR
    SELECT Book_ID, Book_Name, Author, Category, Price
    FROM Books;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET done = 1;

    OPEN book_cursor;

    read_loop: LOOP

        FETCH book_cursor
        INTO b_id, b_name, b_author, b_category, b_price;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT b_id AS Book_ID,
               b_name AS Book_Name,
               b_author AS Author,
               b_category AS Category,
               b_price AS Price;

    END LOOP;

    CLOSE book_cursor;

END $$

DELIMITER ;

-- Execute Procedure
CALL Display_Book_Details();

-- =========================================================
-- PROCEDURE 2
-- CALCULATE TOTAL PRICE OF ALL BOOKS
-- =========================================================

DELIMITER $$

CREATE PROCEDURE Total_Book_Price()
BEGIN

    DECLARE done INT DEFAULT 0;
    DECLARE b_price DECIMAL(10,2);
    DECLARE total DECIMAL(10,2) DEFAULT 0;

    DECLARE price_cursor CURSOR FOR
    SELECT Price FROM Books;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET done = 1;

    OPEN price_cursor;

    read_loop: LOOP

        FETCH price_cursor INTO b_price;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET total = total + b_price;

    END LOOP;

    CLOSE price_cursor;

    SELECT total AS Total_Book_Price;

END $$

DELIMITER ;

-- Execute Procedure
CALL Total_Book_Price();

-- =========================================================
-- PROCEDURE 3
-- FIND BOOKS HAVING PRICE GREATER THAN 500
-- =========================================================

DELIMITER $$

CREATE PROCEDURE Expensive_Books()
BEGIN

    DECLARE done INT DEFAULT 0;

    DECLARE b_name VARCHAR(100);
    DECLARE b_price DECIMAL(10,2);

    DECLARE expensive_cursor CURSOR FOR
    SELECT Book_Name, Price
    FROM Books
    WHERE Price > 500;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET done = 1;

    OPEN expensive_cursor;

    read_loop: LOOP

        FETCH expensive_cursor INTO b_name, b_price;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT b_name AS Book_Name,
               b_price AS Price;

    END LOOP;

    CLOSE expensive_cursor;

END $$

DELIMITER ;

-- Execute Procedure
CALL Expensive_Books();

-- =========================================================
-- PROCEDURE 4
-- UPDATE CATEGORY OF EXPENSIVE BOOKS
-- Books with Price > 500
-- =========================================================

DELIMITER $$

CREATE PROCEDURE Update_Expensive_Book_Category()
BEGIN

    DECLARE done INT DEFAULT 0;
    DECLARE b_id INT;

    DECLARE update_cursor CURSOR FOR
    SELECT Book_ID
    FROM Books
    WHERE Price > 500;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET done = 1;

    OPEN update_cursor;

    read_loop: LOOP

        FETCH update_cursor INTO b_id;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        UPDATE Books
        SET Category = 'Premium'
        WHERE Book_ID = b_id;

    END LOOP;

    CLOSE update_cursor;

END $$

DELIMITER ;

-- Execute Procedure
CALL Update_Expensive_Book_Category();

-- =========================================================
-- DISPLAY UPDATED TABLE
-- =========================================================

SELECT * FROM Books;