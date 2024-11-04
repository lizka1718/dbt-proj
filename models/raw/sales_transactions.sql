{{ config(schema='raw') }}

SELECT
    "Order ID" AS order_id,
    "Order Date" AS order_date,
    "Ship Date" AS ship_date,
    "Sales" AS sales,
    "Quantity" AS quantity,
    "Discount" AS discount,
    "Profit" AS profit,
    "Customer Name" AS customer_name,
    "Segment" AS segment,
    "Country" AS country,
    CURRENT_TIMESTAMP AS loaded_timestamp
FROM {{ source('parquet_input', 'sales_transactions') }}