-- =========================================================
-- RETAIL STORE MANAGEMENT SYSTEM
-- Aggregate Functions, GROUP BY, HAVING
-- =========================================================

-- =========================================================
-- CREATE DATABASE
-- =========================================================

CREATE DATABASE RetailStoreDB;

USE RetailStoreDB;

-- =========================================================
-- CREATE TABLES
-- =========================================================

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    City VARCHAR(50)
);

CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,

    FOREIGN KEY (Customer_ID)
    REFERENCES Customers(Customer_ID)
);

CREATE TABLE Order_Details (
    Order_Detail_ID INT PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT,

    FOREIGN KEY (Order_ID)
    REFERENCES Orders(Order_ID),

    FOREIGN KEY (Product_ID)
    REFERENCES Products(Product_ID)
);

-- =========================================================
-- INSERT DATA INTO Customers
-- =========================================================

INSERT INTO Customers VALUES
(1, 'Aman', 'Pune'),
(2, 'Sneha', 'Mumbai'),
(3, 'Rahul', 'Delhi'),
(4, 'Riya', 'Pune');

-- =========================================================
-- INSERT DATA INTO Products
-- =========================================================

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Mobile', 'Electronics', 25000),
(103, 'Shoes', 'Fashion', 3000),
(104, 'Watch', 'Accessories', 5000);

-- =========================================================
-- INSERT DATA INTO Orders
-- =========================================================

INSERT INTO Orders VALUES
(1001, 1, '2025-05-01'),
(1002, 2, '2025-05-02'),
(1003, 3, '2025-05-03'),
(1004, 1, '2025-05-04');

-- =========================================================
-- INSERT DATA INTO Order_Details
-- =========================================================

INSERT INTO Order_Details VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1),
(4, 1003, 104, 3),
(5, 1004, 103, 1);

-- =========================================================
-- DISPLAY TABLES
-- =========================================================

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_Details;

-- =========================================================
-- TOTAL NUMBER OF CUSTOMERS
-- =========================================================

SELECT COUNT(*) AS Total_Customers
FROM Customers;

-- =========================================================
-- TOTAL NUMBER OF ORDERS
-- =========================================================

SELECT COUNT(*) AS Total_Orders
FROM Orders;

-- =========================================================
-- TOTAL SALES OF STORE
-- =========================================================

SELECT SUM(P.Price * OD.Quantity) AS Total_Sales
FROM Products P
JOIN Order_Details OD
ON P.Product_ID = OD.Product_ID;

-- =========================================================
-- AVERAGE PRODUCT PRICE
-- =========================================================

SELECT AVG(Price) AS Average_Product_Price
FROM Products;

-- =========================================================
-- HIGHEST PRODUCT PRICE
-- =========================================================

SELECT MAX(Price) AS Highest_Product_Price
FROM Products;

-- =========================================================
-- LOWEST PRODUCT PRICE
-- =========================================================

SELECT MIN(Price) AS Lowest_Product_Price
FROM Products;

-- =========================================================
-- PRODUCT PERFORMANCE
-- TOTAL QUANTITY SOLD PER PRODUCT
-- =========================================================

SELECT P.Product_Name,
       SUM(OD.Quantity) AS Total_Quantity_Sold
FROM Products P
JOIN Order_Details OD
ON P.Product_ID = OD.Product_ID
GROUP BY P.Product_Name;

-- =========================================================
-- CATEGORY WISE SALES
-- =========================================================

SELECT P.Category,
       SUM(P.Price * OD.Quantity) AS Total_Category_Sales
FROM Products P
JOIN Order_Details OD
ON P.Product_ID = OD.Product_ID
GROUP BY P.Category;

-- =========================================================
-- CUSTOMER DISTRIBUTION CITY WISE
-- =========================================================

SELECT City,
       COUNT(*) AS Total_Customers
FROM Customers
GROUP BY City;

-- =========================================================
-- CUSTOMER WISE NUMBER OF ORDERS
-- =========================================================

SELECT C.Customer_Name,
       COUNT(O.Order_ID) AS Number_Of_Orders
FROM Customers C
JOIN Orders O
ON C.Customer_ID = O.Customer_ID
GROUP BY C.Customer_Name;

-- =========================================================
-- HAVING CLAUSE
-- SHOW PRODUCTS WITH SALES > 2 QUANTITY
-- =========================================================

SELECT P.Product_Name,
       SUM(OD.Quantity) AS Total_Quantity_Sold
FROM Products P
JOIN Order_Details OD
ON P.Product_ID = OD.Product_ID
GROUP BY P.Product_Name
HAVING SUM(OD.Quantity) > 2;

-- =========================================================
-- HAVING CLAUSE
-- SHOW CITIES HAVING MORE THAN 1 CUSTOMER
-- =========================================================

SELECT City,
       COUNT(*) AS Total_Customers
FROM Customers
GROUP BY City
HAVING COUNT(*) > 1;