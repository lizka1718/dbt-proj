-- tests/test_customer_names.sql

WITH invalid_customers AS (
    SELECT customer_name
    FROM {{ ref('dim_customers') }}  -- Replace with the name of your model
    WHERE
        customer_name IS NULL
        OR customer_name = ''
        OR customer_name NOT LIKE '% %'  -- Check if it doesn't contain a space
)

SELECT *
FROM invalid_customers
