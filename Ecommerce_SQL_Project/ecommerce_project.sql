
-- ============================================
-- E-COMMERCE DATABASE ANALYSIS PROJECT
-- DBMS: MySQL 8.0+
-- ============================================

-- 1. CREATE DATABASE

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;


-- 2. CREATE TABLES

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    city VARCHAR(80),
    signup_date DATE NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category VARCHAR(80) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    CHECK (price >= 0),
    CHECK (stock >= 0)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    CHECK (status IN (
        'Completed', 'Pending',
        'Cancelled', 'Returned'
    ))
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id),
    CHECK (quantity > 0),
    CHECK (unit_price >= 0),
    UNIQUE (order_id, product_id)
);


-- 3. INSERT SAMPLE CUSTOMERS

INSERT INTO customers
(customer_id, customer_name, email, city, signup_date)
VALUES
(1, 'Aisha Khan', 'aisha@example.com', 'Bengaluru', '2025-01-05'),
(2, 'Rahul Das', 'rahul@example.com', 'Kolkata', '2025-01-12'),
(3, 'Meera Nair', 'meera@example.com', 'Kochi', '2025-02-02'),
(4, 'Arjun Rao', NULL, 'Bengaluru', '2025-02-18'),
(5, 'Sara Ali', 'sara@example.com', 'Hyderabad', '2025-03-09'),
(6, 'Dev Patel', 'dev@example.com', 'Mumbai', '2025-03-21'),
(7, 'Neha Singh', 'neha@example.com', 'Delhi', '2025-04-11'),
(8, 'Kabir Sen', 'kabir@example.com', 'Pune', '2025-04-26');


-- 4. INSERT SAMPLE PRODUCTS

INSERT INTO products
(product_id, product_name, category, price, stock)
VALUES
(101, 'Wireless Mouse', 'Electronics', 799.00, 45),
(102, 'Mechanical Keyboard', 'Electronics', 2499.00, 20),
(103, 'USB-C Hub', 'Electronics', 1599.00, 30),
(104, 'Water Bottle', 'Home', 499.00, 80),
(105, 'Desk Lamp', 'Home', 1199.00, 25),
(106, 'Notebook Set', 'Stationery', 299.00, 100),
(107, 'Backpack', 'Accessories', 1899.00, 18),
(108, 'Phone Stand', 'Accessories', 399.00, 60),
(109, 'Bluetooth Speaker', 'Electronics', 2199.00, 15),
(110, 'Pen Pack', 'Stationery', 149.00, 120);


-- 5. INSERT SAMPLE ORDERS

INSERT INTO orders
(order_id, customer_id, order_date, status)
VALUES
(1001, 1, '2025-01-10', 'Completed'),
(1002, 2, '2025-01-15', 'Completed'),
(1003, 3, '2025-02-08', 'Completed'),
(1004, 1, '2025-02-20', 'Pending'),
(1005, 4, '2025-03-02', 'Completed'),
(1006, 5, '2025-03-12', 'Completed'),
(1007, 6, '2025-03-28', 'Cancelled'),
(1008, 2, '2025-04-05', 'Completed'),
(1009, 7, '2025-04-19', 'Returned'),
(1010, 8, '2025-05-03', 'Completed'),
(1011, 3, '2025-05-17', 'Completed'),
(1012, 5, '2025-05-25', 'Pending');


-- 6. INSERT ORDER ITEMS

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 101, 2, 799.00),
(2, 1001, 106, 3, 299.00),
(3, 1002, 102, 1, 2499.00),
(4, 1002, 108, 2, 399.00),
(5, 1003, 109, 1, 2199.00),
(6, 1003, 104, 2, 499.00),
(7, 1004, 103, 1, 1599.00),
(8, 1005, 107, 1, 1899.00),
(9, 1005, 110, 4, 149.00),
(10, 1006, 105, 2, 1199.00),
(11, 1006, 101, 1, 799.00),
(12, 1007, 104, 1, 499.00),
(13, 1008, 102, 1, 2499.00),
(14, 1008, 103, 1, 1599.00),
(15, 1009, 107, 1, 1899.00),
(16, 1010, 108, 3, 399.00),
(17, 1010, 106, 5, 299.00),
(18, 1011, 109, 2, 2199.00),
(19, 1011, 110, 2, 149.00),
(20, 1012, 105, 1, 1199.00);


-- ============================================
-- 7. BASIC SQL QUERIES
-- SELECT, WHERE, ORDER BY, LIMIT, ALIASES
-- ============================================

-- Display all products
SELECT * FROM products;

-- Find products costing more than 1000
SELECT product_name, price
FROM products
WHERE price > 1000;

-- Sort products by price
SELECT product_name, price
FROM products
ORDER BY price DESC;

-- Display the five most expensive products
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- Use aliases
SELECT product_name AS product,
       price AS price_in_inr
FROM products;


-- ============================================
-- 8. NULL HANDLING
-- COALESCE, NULLIF, IS NULL
-- ============================================

-- Find customers without email addresses
SELECT customer_id, customer_name, email
FROM customers
WHERE email IS NULL;

-- Replace NULL email with a readable message
SELECT customer_name,
       COALESCE(email, 'Email not provided') AS email
FROM customers;

-- NULLIF returns NULL when both values are equal
SELECT NULLIF(0, 0) AS result;


-- ============================================
-- 9. AGGREGATE FUNCTIONS
-- COUNT, SUM, AVG, GROUP BY, HAVING
-- ============================================

-- Count all products
SELECT COUNT(*) AS total_products
FROM products;

-- Calculate the average product price
SELECT AVG(price) AS average_price
FROM products;

-- Calculate total stock
SELECT SUM(stock) AS total_stock
FROM products;

-- Count products in each category
SELECT category,
       COUNT(*) AS total_products
FROM products
GROUP BY category;

-- Find categories with at least two products
SELECT category,
       COUNT(*) AS total_products,
       ROUND(AVG(price), 2) AS average_price
FROM products
GROUP BY category
HAVING COUNT(*) >= 2
ORDER BY average_price DESC;


-- ============================================
-- 10. JOINS
-- INNER, LEFT, RIGHT, FULL OUTER
-- ============================================

-- INNER JOIN: orders with customer details
SELECT o.order_id,
       c.customer_name,
       o.order_date,
       o.status
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;

-- LEFT JOIN: all customers and their order counts
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY order_count DESC;

-- RIGHT JOIN: all products, including unpurchased ones
SELECT p.product_id,
       p.product_name,
       COUNT(oi.order_item_id) AS times_ordered
FROM order_items oi
RIGHT JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY times_ordered DESC;

-- FULL OUTER JOIN equivalent in MySQL
-- MySQL does not directly support FULL OUTER JOIN.
SELECT c.customer_id,
       c.customer_name,
       o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id

UNION

SELECT c.customer_id,
       c.customer_name,
       o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;


-- ============================================
-- 11. CASE WHEN
-- ============================================

-- Classify products by price
SELECT product_name,
       price,
       CASE
           WHEN price >= 2000 THEN 'Premium'
           WHEN price >= 1000 THEN 'Mid-range'
           ELSE 'Budget'
       END AS price_segment
FROM products
ORDER BY price DESC;


-- ============================================
-- 12. STRING AND DATE FUNCTIONS
-- ============================================

-- String functions
SELECT customer_name,
       UPPER(city) AS city_uppercase,
       LENGTH(customer_name) AS name_length
FROM customers;

-- Display signup month and year
SELECT customer_name,
       DATE_FORMAT(signup_date, '%b %Y') AS signup_month
FROM customers;


-- ============================================
-- 13. MINI PROJECT ANALYSIS
-- ============================================

-- Q1. TOP PRODUCTS BY REVENUE
-- Only completed orders are counted.

SELECT p.product_name,
       SUM(oi.quantity) AS units_sold,
       ROUND(SUM(oi.quantity * oi.unit_price), 2)
           AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 5;


-- Q2. CUSTOMER SPENDING

SELECT c.customer_id,
       c.customer_name,
       ROUND(SUM(oi.quantity * oi.unit_price), 2)
           AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;


-- Q3. MONTHLY ORDER TRENDS

SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;


-- Q4. MONTHLY REVENUE

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
       ROUND(SUM(oi.quantity * oi.unit_price), 2)
           AS monthly_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY order_month;


-- Q5. CATEGORY-WISE REVENUE

SELECT p.category,
       SUM(oi.quantity) AS units_sold,
       ROUND(SUM(oi.quantity * oi.unit_price), 2)
           AS revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.category
ORDER BY revenue DESC;


-- Q6. CUSTOMER SPENDING SEGMENTS

SELECT customer_name,
       total_spent,
       CASE
           WHEN total_spent >= 5000 THEN 'High spender'
           WHEN total_spent >= 2000 THEN 'Medium spender'
           ELSE 'Low spender'
       END AS spending_segment
FROM (
    SELECT c.customer_id,
           c.customer_name,
           COALESCE(
               SUM(
                   CASE
                       WHEN o.status = 'Completed'
                       THEN oi.quantity * oi.unit_price
                       ELSE 0
                   END
               ), 0
           ) AS total_spent
    FROM customers c
    LEFT JOIN orders o
    ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
) AS customer_totals
ORDER BY total_spent DESC;


-- Q7. ORDER STATUS SUMMARY

SELECT status,
       COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- ============================================
-- END OF PROJECT
-- ============================================