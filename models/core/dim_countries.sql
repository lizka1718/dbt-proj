{{ config(materialized='table', schema='dm') }}

SELECT DISTINCT
    DENSE_RANK() OVER (ORDER BY country) AS country_id,
    country
FROM {{ ref('sales_transactions') }}
