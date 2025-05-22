{{ config(materialized='view') }}

with source as (

    select *
    from {{ ref('sales_regions') }}

), 

renamed as (

    select *
    from source

), 

final as (
    
    select *
    from renamed

)

select * from final
