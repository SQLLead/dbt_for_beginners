{{ config(
    materialized='incremental',
    unique_key='event_id'
) }}

with source as (
    select
        event_id,
        user_id,
        page,
        event_type,
        event_timestamp,
        current_timestamp() as load_time
    from {{ ref('stg_web_logs') }}

    {% if is_incremental() %}
        where event_id not in (
            select event_id from {{ this }}
        )
    {% endif %}
)

select * from source
