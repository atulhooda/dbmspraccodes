-- =========================================================
-- PHARMACY MANAGEMENT SYSTEM
-- SUBQUERIES
-- =========================================================

-- =========================================================
-- CREATE DATABASE
-- =========================================================

CREATE DATABASE PharmacyDB;

USE PharmacyDB;

-- =========================================================
-- CREATE TABLES
-- =========================================================

CREATE TABLE Categories (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(100)
);

CREATE TABLE Suppliers (
    Supplier_ID INT PRIMARY KEY,
    Supplier_Name VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Medicines (
    Medicine_ID INT PRIMARY KEY,
    Medicine_Name VARCHAR(100),
    Category_ID INT,
    Supplier_ID INT,
    Price DECIMAL(10,2),
    Stock INT,

    FOREIGN KEY (Category_ID)
    REFERENCES Categories(Category_ID),

    FOREIGN KEY (Supplier_ID)
    REFERENCES Suppliers(Supplier_ID)
);

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Medicine_ID INT,
    Quantity INT,
    Sale_Date DATE,

    FOREIGN KEY (Customer_ID)
    REFERENCES Customers(Customer_ID),

    FOREIGN KEY (Medicine_ID)
    REFERENCES Medicines(Medicine_ID)
);

-- =========================================================
-- INSERT DATA INTO Categories
-- =========================================================

INSERT INTO Categories VALUES
(1, 'Antibiotics'),
(2, 'Painkillers'),
(3, 'Vitamins');

-- =========================================================
-- INSERT DATA INTO Suppliers
-- =========================================================

INSERT INTO Suppliers VALUES
(101, 'Health Pharma', 'Pune'),
(102, 'MediCare Ltd', 'Mumbai'),
(103, 'Life Drugs', 'Delhi');

-- =========================================================
-- INSERT DATA INTO Medicines
-- =========================================================

INSERT INTO Medicines VALUES
(201, 'Amoxicillin', 1, 101, 120, 50),
(202, 'Paracetamol', 2, 102, 40, 100),
(203, 'Vitamin C', 3, 103, 80, 70),
(204, 'Ibuprofen', 2, 102, 60, 90);

-- =========================================================
-- INSERT DATA INTO Customers
-- =========================================================

INSERT INTO Customers VALUES
(301, 'Aman', 'Pune'),
(302, 'Sneha', 'Mumbai'),
(303, 'Rahul', 'Delhi');

-- =========================================================
-- INSERT DATA INTO Sales
-- =========================================================

INSERT INTO Sales VALUES
(1, 301, 201, 2, '2025-05-01'),
(2, 302, 202, 5, '2025-05-02'),
(3, 303, 203, 3, '2025-05-03'),
(4, 301, 204, 4, '2025-05-04');

-- =========================================================
-- DISPLAY TABLES
-- =========================================================

SELECT * FROM Categories;
SELECT * FROM Suppliers;
SELECT * FROM Medicines;
SELECT * FROM Customers;
SELECT * FROM Sales;

-- =========================================================
-- SUBQUERY 1
-- Medicines with price greater than average price
-- =========================================================

SELECT Medicine_Name, Price
FROM Medicines
WHERE Price >
(
    SELECT AVG(Price)
    FROM Medicines
);

-- =========================================================
-- SUBQUERY 2
-- Medicines belonging to Painkillers category
-- =========================================================

SELECT Medicine_Name
FROM Medicines
WHERE Category_ID =
(
    SELECT Category_ID
    FROM Categories
    WHERE Category_Name = 'Painkillers'
);

-- =========================================================
-- SUBQUERY 3
-- Customers who purchased Paracetamol
-- =========================================================

SELECT Customer_Name
FROM Customers
WHERE Customer_ID IN
(
    SELECT Customer_ID
    FROM Sales
    WHERE Medicine_ID =
    (
        SELECT Medicine_ID
        FROM Medicines
        WHERE Medicine_Name = 'Paracetamol'
    )
);

-- =========================================================
-- SUBQUERY 4
-- Supplier supplying the most expensive medicine
-- =========================================================

SELECT Supplier_Name
FROM Suppliers
WHERE Supplier_ID =
(
    SELECT Supplier_ID
    FROM Medicines
    WHERE Price =
    (
        SELECT MAX(Price)
        FROM Medicines
    )
);

-- =========================================================
-- SUBQUERY 5
-- Medicines having stock less than average stock
-- =========================================================

SELECT Medicine_Name, Stock
FROM Medicines
WHERE Stock <
(
    SELECT AVG(Stock)
    FROM Medicines
);

-- =========================================================
-- SUBQUERY 6
-- Customers who bought medicines costing above 50
-- =========================================================

SELECT Customer_Name
FROM Customers
WHERE Customer_ID IN
(
    SELECT Customer_ID
    FROM Sales
    WHERE Medicine_ID IN
    (
        SELECT Medicine_ID
        FROM Medicines
        WHERE Price > 50
    )
);

-- =========================================================
-- SUBQUERY 7
-- Categories having medicines with stock above 80
-- =========================================================

SELECT Category_Name
FROM Categories
WHERE Category_ID IN
(
    SELECT Category_ID
    FROM Medicines
    WHERE Stock > 80
);

-- =========================================================
-- SUBQUERY 8
-- Medicines never sold
-- =========================================================

SELECT Medicine_Name
FROM Medicines
WHERE Medicine_ID NOT IN
(
    SELECT Medicine_ID
    FROM Sales
);

-- =========================================================
-- SUBQUERY 9
-- Customers from same city as supplier 'Health Pharma'
-- =========================================================

SELECT Customer_Name, City
FROM Customers
WHERE City =
(
    SELECT City
    FROM Suppliers
    WHERE Supplier_Name = 'Health Pharma'
);

-- =========================================================
-- SUBQUERY 10
-- Medicines purchased by customer 'Aman'
-- =========================================================

SELECT Medicine_Name
FROM Medicines
WHERE Medicine_ID IN
(
    SELECT Medicine_ID
    FROM Sales
    WHERE Customer_ID =
    (
        SELECT Customer_ID
        FROM Customers
        WHERE Customer_Name = 'Aman'
    )
);