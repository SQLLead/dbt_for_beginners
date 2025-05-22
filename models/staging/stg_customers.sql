with source as (

    select *
    from {{ source('snowflake_sources', 'customers') }}

),

renamed as (

    select 
        CUSTOMERID as CUSTOMER_ID,
        CUSTOMERNAME AS CUSTOMER_NAME,
        CUSTOMERADDRESS AS CUSTOMER_ADDRESS,
        CUSTOMERCITY AS CUSTOMER_CITY,
        CUSTOMERSTATE AS CUSTOMER_STATE,
        CUSTOMERZIP AS CUSTOMER_ZIP,
        CUSTOMERPHONE AS CUSTOMER_PHONE
    from source

), 

final as (

    select *
    from renamed

)

select * from final