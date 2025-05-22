with source as (

    select *
    from {{ source('snowflake_sources', 'sales_order_headers') }}

),

renamed as (

    select 
        salesorderid as sales_order_id,
        customerid as customer_id,
        salesdate as sales_date,
        salesamount,
        to_decimal(replace(replace(salesamount, ',', ''), '$', ''), 12, 2) as sales_amount,
        to_decimal(replace(replace(taxamount, ',', ''), '$', ''), 12, 2) as tax_amount,
        to_decimal(replace(replace(shippingamount, ',', ''), '$', ''), 12, 2) as shipping_amount,
        to_decimal(sales_amount + tax_amount + shipping_amount, 12, 2) as total_amount
    from source

),

final as (

    select *
    from renamed

)

select * from final