SELECT
    d.year,
    d.month,
    SUM(s.sales) AS total_sales,
    COUNT(DISTINCT s.order_id) AS total_orders
FROM {{ ref('fact_sales_transactions') }} AS s
JOIN {{ ref('dim_dates') }} AS d ON s.order_date_id = d.order_date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month
