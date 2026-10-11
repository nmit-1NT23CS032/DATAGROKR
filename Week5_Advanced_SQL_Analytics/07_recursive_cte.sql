
-- Generate numbers from 1 to 10
WITH RECURSIVE number_series AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM number_series
    WHERE n < 10
)
SELECT n
FROM number_series;
