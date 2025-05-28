-- Show high-value sales orders by customer and region

with orders as (
    select *
    from {{ ref('fct_sales_orders') }}
),

high_value as (
    select *
    from orders
    where {{ is_high_value_order('sales_amount') }}
),

summary as (
    select
        customer_name,
        sales_region,
        count(*) as high_value_order_count,
        sum(sales_amount) as total_high_value_sales,
        max(sales_amount) as largest_order
    from high_value
    group by customer_name, sales_region
    order by total_high_value_sales desc
)

select * from summary