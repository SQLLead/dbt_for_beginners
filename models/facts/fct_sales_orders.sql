with sales_order_headers as (

    select *
    from {{ ref('dim_sales_order_headers') }}

),

sales_order_details as (

    select *
    from {{ ref('dim_sales_order_details') }}

),

sales_regions as (

    select * 
    from {{ ref('dim_sales_regions') }}

),

customers as (

    select *
    from {{ ref('dim_customers') }}

),

final as (

    select 
        hdrs.sales_order_id,
        dtls.sales_order_detail_id,
        cust.customer_name,
        hdrs.sales_date,
        dtls.product_id,
        dtls.product_price,
        dtls.order_quantity,
        hdrs.sales_amount,
        hdrs.tax_amount,
        hdrs.shipping_amount,
          hdrs.sales_amount 
        + hdrs.tax_amount
        + hdrs.shipping_amount as total_amount,
        rgns.sales_region

    from sales_order_headers as hdrs
    left join sales_order_details as dtls
      on hdrs.sales_order_id = dtls.sales_order_id
    left join customers as cust
      on hdrs.customer_id = cust.customer_id
    left join sales_regions as rgns
      on cust.customer_zip between rgns.sales_region_zip_begin and rgns.sales_region_zip_end

)

select * from final