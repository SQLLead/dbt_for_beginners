with orders as (

    select *
    from {{ ref('fct_sales_orders') }}

),

order_totals as (

    select
        customer_name,
        sales_region,
        sum(sales_amount) as total_sales
    from orders
    group by customer_name, sales_region

),

ranked_customers as (

    select
        *,
        row_number() over (
            partition by sales_region
            order by total_sales desc
        ) as customer_rank
    from order_totals

),

top_1 as (

    select *
    from ranked_customers
    where customer_rank <= 1

)

select * from top_1
order by sales_region, customer_rank
