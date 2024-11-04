{{ config(materialized='table') }}

SELECT
    s.segment,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    SUM(ft.sales) AS total_sales,
    AVG(ft.sales) AS average_sales,
    COUNT(ft.order_id) AS total_orders
FROM {{ ref('dim_segments') }} AS s
LEFT JOIN {{ ref('fact_sales_transactions') }} AS ft ON s.segment_id = ft.segment_id
LEFT JOIN {{ ref('dim_customers') }} AS c ON ft.customer_id = c.customer_id
GROUP BY s.segment
ORDER BY total_sales DESC;

