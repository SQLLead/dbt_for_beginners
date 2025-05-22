with base as (

    select *
    from {{ ref('stg_sales_regions') }}

),

final as (

    select *
    from base

)

select * from final
