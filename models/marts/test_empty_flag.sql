with payment as (
    select * from {{ source('stripe', 'payment') }}
),
stg_payment as (
    select * from {{ ref('stg_stripe__payments') }}
),
final as (
    select
        stg_payment.*,
        sysdate() as dt
    from stg_payment
    left join payment
        on stg_payment.payment_id = payment.id
)
select * from final