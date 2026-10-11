
USE week5_sales_project;

-- Query 1: Sales details using dimension tables
SELECT
    s.sales_id,
    s.order_id,
    d.date_key AS sale_date,
    c.customer_name,
    p.product_name,
    p.category,
    s.quantity,
    s.unit_price,
    s.quantity * s.unit_price AS revenue
FROM fact_sales s
JOIN dim_customers c
    ON s.customer_id = c.customer_id
JOIN dim_products p
    ON s.product_id = p.product_id
JOIN dim_dates d
    ON s.date_key = d.date_key
ORDER BY d.date_key;

-- Query 2: Revenue by product category
SELECT
    p.category,
    SUM(s.quantity * s.unit_price) AS total_revenue,
    SUM(s.quantity) AS units_sold
FROM fact_sales s
JOIN dim_products p
    ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Query 3: Revenue by customer
SELECT
    c.customer_name,
    SUM(s.quantity * s.unit_price) AS total_spent
FROM fact_sales s
JOIN dim_customers c
    ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- Query 4: CASE WHEN classification
SELECT
    sales_id,
    quantity * unit_price AS revenue,
    CASE
        WHEN quantity * unit_price >= 50000 THEN 'High'
        WHEN quantity * unit_price >= 10000 THEN 'Medium'
        ELSE 'Low'
    END AS sale_category
FROM fact_sales;
