{{
    config(
        schema='test_schema'
    )
}}

select * from {{ ref('example_incremental_model') }}