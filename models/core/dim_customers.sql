with customers as (

    select *
    from {{ ref('stg_customers') }}

),

sales_regions as (

    select *
    from {{ ref('stg_sales_regions') }}

),

final as (

    select 
        customers.CUSTOMER_ID,
        customers.CUSTOMER_NAME,
        customers.CUSTOMER_ADDRESS,
        customers.CUSTOMER_CITY,
        customers.CUSTOMER_STATE,
        customers.CUSTOMER_ZIP,
        customers.CUSTOMER_PHONE,
        sales_regions.SALES_REGION AS CUSTOMER_REGION
    from customers
    left join sales_regions 
    on customers.CUSTOMER_ZIP between sales_regions.SALES_REGION_ZIP_BEGIN and sales_regions.SALES_REGION_ZIP_END

)

select * from final
