{{ config(materialized='table', schema='dm') }}

SELECT DISTINCT
    DENSE_RANK() OVER (ORDER BY customer_name) AS customer_id,
    customer_name
FROM {{ ref('sales_transactions') }}
