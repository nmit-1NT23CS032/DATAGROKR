
USE week5_sales_project;

-- 1. Monthly revenue using a CTE
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(date_key, '%Y-%m') AS sales_month,
        SUM(quantity * unit_price) AS revenue
    FROM fact_sales
    GROUP BY DATE_FORMAT(date_key, '%Y-%m')
),
monthly_comparison AS (
    SELECT
        sales_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    sales_month,
    revenue,
    previous_month_revenue,
    ROUND(
        (revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0) * 100,
        2
    ) AS mom_growth_percentage
FROM monthly_comparison
ORDER BY sales_month;

-- 2. Months with revenue above average
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(date_key, '%Y-%m') AS sales_month,
        SUM(quantity * unit_price) AS revenue
    FROM fact_sales
    GROUP BY DATE_FORMAT(date_key, '%Y-%m')
)
SELECT sales_month, revenue
FROM monthly_revenue
WHERE revenue > (
    SELECT AVG(revenue)
    FROM monthly_revenue
)
ORDER BY revenue DESC;

-- 3. Scalar subquery: Products priced above average
SELECT product_name, price
FROM dim_products
WHERE price > (
    SELECT AVG(price)
    FROM dim_products
);

-- 4. EXISTS: Customers who have made a purchase
SELECT c.customer_id, c.customer_name
FROM dim_customers c
WHERE EXISTS (
    SELECT 1
    FROM fact_sales s
    WHERE s.customer_id = c.customer_id
);

-- 5. NOT EXISTS: Customers without a purchase
SELECT c.customer_id, c.customer_name
FROM dim_customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM fact_sales s
    WHERE s.customer_id = c.customer_id
);

-- 6. Correlated subquery: Sales above their category average
SELECT
    s.sales_id,
    p.product_name,
    p.category,
    s.quantity * s.unit_price AS revenue
FROM fact_sales s
JOIN dim_products p
    ON s.product_id = p.product_id
WHERE s.quantity * s.unit_price > (
    SELECT AVG(s2.quantity * s2.unit_price)
    FROM fact_sales s2
    JOIN dim_products p2
        ON s2.product_id = p2.product_id
    WHERE p2.category = p.category
);

-- 7. UNION: Combine customer cities and product categories
SELECT city AS item, 'City' AS item_type
FROM dim_customers
UNION
SELECT category AS item, 'Category' AS item_type
FROM dim_products;

-- 8. INTERSECT: Common values between two result sets
SELECT city AS location
FROM dim_customers
INTERSECT
SELECT city AS location
FROM dim_customers
WHERE country = 'India';

-- 9. EXCEPT: Cities excluding Bengaluru
SELECT city
FROM dim_customers
EXCEPT
SELECT city
FROM dim_customers
WHERE city = 'Bengaluru';

-- 10. ROLLUP: Revenue subtotals
SELECT
    p.category,
    p.product_name,
    SUM(s.quantity * s.unit_price) AS revenue
FROM fact_sales s
JOIN dim_products p
    ON s.product_id = p.product_id
GROUP BY p.category, p.product_name WITH ROLLUP;
