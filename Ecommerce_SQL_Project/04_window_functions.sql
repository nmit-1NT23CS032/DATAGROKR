
USE week5_sales_project;

-- 1. RANK and DENSE_RANK: Rank products by total revenue
WITH product_revenue AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(s.quantity * s.unit_price) AS revenue
    FROM fact_sales s
    JOIN dim_products p
        ON s.product_id = p.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT
    product_name,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank,
    DENSE_RANK() OVER (ORDER BY revenue DESC) AS dense_revenue_rank
FROM product_revenue;

-- 2. LAG and LEAD: Compare consecutive sales
SELECT
    sales_id,
    date_key,
    quantity * unit_price AS revenue,
    LAG(quantity * unit_price) OVER (
        ORDER BY date_key, sales_id
    ) AS previous_sale,
    LEAD(quantity * unit_price) OVER (
        ORDER BY date_key, sales_id
    ) AS next_sale
FROM fact_sales;

-- 3. Window frame: Running revenue total
SELECT
    date_key,
    sales_id,
    quantity * unit_price AS revenue,
    SUM(quantity * unit_price) OVER (
        ORDER BY date_key, sales_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue
FROM fact_sales;

-- 4. NTILE: Divide sales into four groups
SELECT
    sales_id,
    quantity * unit_price AS revenue,
    NTILE(4) OVER (
        ORDER BY quantity * unit_price DESC
    ) AS sales_quartile
FROM fact_sales;

-- 5. PARTITION BY: Rank sales within each category
WITH sales_by_category AS (
    SELECT
        s.sales_id,
        p.category,
        s.quantity * s.unit_price AS revenue
    FROM fact_sales s
    JOIN dim_products p
        ON s.product_id = p.product_id
)
SELECT
    sales_id,
    category,
    revenue,
    RANK() OVER (
        PARTITION BY category
        ORDER BY revenue DESC
    ) AS category_rank
FROM sales_by_category;
