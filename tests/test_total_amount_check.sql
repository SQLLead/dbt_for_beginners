SELECT *
FROM {{ ref('fct_sales_orders') }}
WHERE total_amount != sales_amount + tax_amount + shipping_amount
