{% snapshot snapshot_stg_payments %}

{{
    config(
      target_database='THU_TEST_DB',
      target_schema='snapshots',
      unique_key='ID',

      strategy='timestamp',
      updated_at='_BATCHED_AT',
    )
}}

select * from {{ source('stripe', 'payment') }}

{% endsnapshot %}