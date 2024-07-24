{#- 
Explaining Configurations
    - grants: shows how to grant a specific privilege (in this case select) on the object to a role in Snowflake (in this case transformer)
    - post_hook: shows you can run a statement after your model is built
    - alias: sets the name of the object that will be created in the warehouse and overrides the file name. in this case, the model
            will b created as staging_jaffle_shop_customers
    - materialized: overwrites the materialization strategy from the dbt_project.yml file to be table instead of view
    - persist_docs: persists the documentation into the database
    - schema: adjusting the schema that the model gets built in to be a concatenation of the target schema and "jaffle_shop"
    - database: example of how you can overwrite the target database by setting the database in the config. in this example,
                we're overriding to the analytics database (even though that is the same as the target database, just an example)

-#}

{{ 
    config(
        grants = {'select': ['transformer']},
        post_hook = 'select * from {{ this }} limit 1',
        alias = 'staging_jaffle_shop_customers',
        materialized = 'table',
        persist_docs = {"relation": true, "columns": true},
        tags = ['finance'],
        schema = 'jaffle_shop',
        database = 'THU_TEST_DB'
    ) 
}}

{{
    config(
        materialized='table'
    )
}}



with source as (

    select * from {{ source('jaffle_shop', 'customers') }}

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name

    from source

)

select * from renamed
