{{ config(materialized='table', schema='dm') }}

SELECT DISTINCT
    DENSE_RANK() OVER (ORDER BY segment) AS segment_id,
    segment
FROM {{ ref('sales_transactions') }}
