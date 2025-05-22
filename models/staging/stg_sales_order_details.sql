with source as (
    
    select *
    from {{ source('snowflake_sources', 'sales_order_details') }}

),

renamed as (

    select 
          salesorderid as sales_order_id,
          salesorderdetailid as sales_order_detail_id,
          productid as product_id,
          to_decimal(replace(replace(productprice, ',', ''), '$', ''), 12, 2) as product_price,
          to_number(orderquantity) as order_quantity,
          to_decimal(replace(replace(totalprice, ',', ''), '$', ''), 12, 2) as total_price,
    from source

),

final as (

    select * 
    from renamed

)

select * from final