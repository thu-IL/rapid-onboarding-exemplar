{{
    config(
        materialized='incremental',
        unique_key='part_id'
    )
}}

with part as (

    select * from {{ref('stg_tpch__parts')}}

),

final as (
    select
        part_id,
        manufacturer,
        name,
        brand,
        type,
        size,
        container,
        retail_price
    from
        part
)
select *
from final
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where part_id > (select distinct part_id from {{ this }}) 
{% endif %}
order by part_id
