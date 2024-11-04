{{ config(materialized='table', schema='dm') }}

WITH date_range AS (
    SELECT DISTINCT order_date
    FROM {{ ref('sales_transactions') }}
),
calendar AS (
    SELECT
        order_date,
        EXTRACT(YEAR FROM order_date) AS year,
        EXTRACT(MONTH FROM order_date) AS month,
        EXTRACT(DAY FROM order_date) AS day
    FROM date_range
)

SELECT
    ROW_NUMBER() OVER (ORDER BY order_date) AS order_date_id, -- Unique ID for each date
    order_date,
    year,
    month,
    day
FROM calendar