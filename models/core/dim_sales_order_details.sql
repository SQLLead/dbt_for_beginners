with base as (

    select *
    from {{ ref('stg_sales_order_details') }}

), 

final as (
    select *
    from base
)

select * from final
