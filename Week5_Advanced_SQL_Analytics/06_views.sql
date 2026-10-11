
USE week5_sales_project;

-- Standard view: Always reads from the underlying tables
CREATE OR REPLACE VIEW sales_report AS
SELECT
    s.sales_id,
    s.date_key,
    c.customer_name,
    p.product_name,
    p.category,
    s.quantity,
    s.quantity * s.unit_price AS revenue
FROM fact_sales s
JOIN dim_customers c
    ON s.customer_id = c.customer_id
JOIN dim_products p
    ON s.product_id = p.product_id;

SELECT * FROM sales_report;

-- MySQL does not support native materialized views.
-- Simulate one using a summary table.

CREATE TABLE IF NOT EXISTS monthly_sales_summary (
    sales_month CHAR(7) PRIMARY KEY,
    revenue DECIMAL(15,2)
);

-- Refresh the summary table
DELETE FROM monthly_sales_summary;

INSERT INTO monthly_sales_summary (sales_month, revenue)
SELECT
    DATE_FORMAT(date_key, '%Y-%m'),
    SUM(quantity * unit_price)
FROM fact_sales
GROUP BY DATE_FORMAT(date_key, '%Y-%m');

SELECT * FROM monthly_sales_summary
ORDER BY sales_month;
