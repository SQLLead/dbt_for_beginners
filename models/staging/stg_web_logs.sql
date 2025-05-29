{{ config(materialized='view') }}

select
    {{ dbt_utils.generate_surrogate_key(['user_id', 'page', 'event_type', 'event_timestamp']) }} as event_id,
    cast(user_id as integer) as user_id,
    page,
    event_type,
    cast(event_timestamp as timestamp) as event_timestamp
from (
    select * from {{ ref('web_logs_day1') }}
 --   union all 
 --   select * from {{ ref('web_logs_day2') }}
 --   union all
 --   select * from {{ ref('web_logs_day3') }} 
) as unioned_logs


