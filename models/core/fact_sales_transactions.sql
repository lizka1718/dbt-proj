-- models/fact_sales_transactions.sql
{{ config(materialized='table', schema='fact') }}

SELECT
    s.order_id,
    d.order_date,
    s.sales,
    s.quantity,
    s.discount,
    s.profit,
    c.customer_id,
    seg.segment_id,
    co.country_id,
    d.order_date_id,  -- Join with the date dimension
    CURRENT_TIMESTAMP AS loaded_timestamp
FROM {{ ref('sales_transactions') }} AS s
JOIN {{ ref('dim_customers') }} AS c ON s.customer_name = c.customer_name
JOIN {{ ref('dim_segments') }} AS seg ON s.Segment = seg.segment
JOIN {{ ref('dim_countries') }} AS co ON s.Country = co.country
JOIN {{ ref('dim_dates') }} AS d ON s.order_date = d.order_date  -- Join with the date dimension
