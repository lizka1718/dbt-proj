{{ config(materialized='table') }}

WITH monthly_summary AS (
    SELECT
        d.year,
        d.month,
        SUM(s.sales) AS total_sales
    FROM {{ ref('fact_sales_transactions') }} AS s
    JOIN {{ ref('dim_dates') }} AS d ON s.order_date_id = d.order_date_id
    GROUP BY d.year, d.month
)
SELECT
    year,
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY year, month) AS previous_month_sales,
    total_sales - COALESCE(LAG(total_sales) OVER (ORDER BY year, month), 0) AS sales_change
FROM monthly_summary
ORDER BY year, month;

