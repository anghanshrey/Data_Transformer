CREATE DATABASE IF NOT EXISTS data_transformer;

USE data_transformer;

CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE
);

INSERT INTO customers VALUES
(1, 'John', 'Doe', ' john.doe@email.com ', '2022-03-15'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '2021-11-02'),
(3, 'Michael', 'Brown', 'michael@email.com', '2023-01-10'),
(4, 'David', 'Wilson', ' david@email.com ', '2022-07-20'),
(5, 'Sarah', 'Taylor', 'sarah@email.com', '2023-05-18'),
(6, 'Robert', 'Lee', 'robert@email.com', '2024-02-10');

CREATE TABLE orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),

    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID)
);

INSERT INTO orders VALUES
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 200.75),
(103, 1, '2023-07-05', 1200.00),
(104, 3, '2023-08-10', 750.00),
(105, 4, '2023-09-15', 450.00),
(106, 5, '2023-10-20', 1500.00),
(107, 2, '2023-11-25', 600.00);

CREATE TABLE employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

INSERT INTO employees VALUES
(1, 'Mark', 'Johnson', 'Sales', '2020-01-15', 50000),
(2, 'Susan', 'Lee', 'HR', '2021-03-20', 55000),
(3, 'David', 'Brown', 'IT', '2019-06-10', 75000),
(4, 'John', 'Smith', 'Finance', '2022-08-12', 35000),
(5, 'Robert', 'Wilson', 'IT', '2018-04-25', 90000),
(6, 'Priya', 'Shah', 'Sales', '2023-02-15', 45000);

SELECT
c.CustomerID,
c.FirstName,
c.LastName,
o.OrderID,
o.OrderDate,
o.TotalAmount
FROM customers c
INNER JOIN orders o
ON c.CustomerID = o.CustomerID;

SELECT
c.CustomerID,
c.FirstName,
c.LastName,
o.OrderID,
o.TotalAmount
FROM customers c
LEFT JOIN orders o
ON c.CustomerID = o.CustomerID;

SELECT
c.CustomerID,
c.FirstName,
c.LastName,
o.OrderID,
o.TotalAmount
FROM customers c
RIGHT JOIN orders o
ON c.CustomerID = o.CustomerID;

SELECT
c.CustomerID,
c.FirstName,
o.OrderID,
o.TotalAmount
FROM customers c
LEFT JOIN orders o
ON c.CustomerID = o.CustomerID

UNION

SELECT
    c.CustomerID,
    c.FirstName,
    o.OrderID,
    o.TotalAmount
FROM customers c
RIGHT JOIN orders o
ON c.CustomerID = o.CustomerID;

SELECT DISTINCT
c.CustomerID,
c.FirstName,
c.LastName
FROM customers c
INNER JOIN orders o
ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM orders
);

SELECT *
FROM employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM employees
);

SELECT
OrderID,
OrderDate,
YEAR(OrderDate) AS OrderYear,
MONTH(OrderDate) AS OrderMonth
FROM orders;

SELECT
OrderID,
OrderDate,
CURDATE() AS CurrentDate,
DATEDIFF(CURDATE(), orderDate) AS Daysdifference
FROM orders;

SELECT
OrderID,
OrderDate,
DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedDate
FROM orders;

SELECT
EmployeeID,
CONCAT(FirstName, ' ', LastName) AS FullName
FROM employees;

SELECT
EmployeeID,
FirstName,
REPLACE(FirstName, 'John', 'Jonathan') AS UpdatedName
FROM employees;

SELECT
EmployeeID,
UPPER(FirstName) AS UpperFirstName,
LOWER(LastName) AS LowerLastName
FROM employees;

SELECT
CustomerID,
Email,
TRIM(Email) AS CleanEmail
FROM customers;

SELECT
OrderID,
OrderDate,
TotalAmount,
SUM(TotalAmount) OVER ( ORDER BY OrderDate, OrderID) As RunningTotal
FROM Orders;

SELECT
OrderID,
TotalAmount,
RANK() OVER (ORDER BY TotalAmount DESC) AS OrderRank
FROM orders;


SELECT
OrderID,
TotalAmount,

CASE
    WHEN TotalAmount > 1000 THEN '10% Discount'
    WHEN TotalAmount > 500 THEN '5% Discount'
    ELSE '0% Discount'
END AS Discount
FROM orders;

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    CASE
        WHEN Salary >= 70000 THEN 'High'
        WHEN Salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM employees;