with base as (

    select *
    from {{ ref('stg_sales_order_headers') }}

), 

final as (

    select 
        sales_order_id,
        customer_id,
        sales_date,
        sales_amount,
        tax_amount,
        shipping_amount,
        case when {{ is_high_value_order('sales_amount') }} then 'high' else 'standard' end as order_tier
    from base
)

select * from final