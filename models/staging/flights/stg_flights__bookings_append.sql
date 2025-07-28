{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append', 
        tags = ['bookings']
    )
}}
SELECT
    book_ref,
    {{ bookref_to_bigint(column_name='book_ref') }} as book_ref_bigint,
    book_date,
    total_amount
FROM
    {{ source('demo_src', 'bookings') }}

{% if is_incremental() %}
    {{ limit_data_dev(column_name='book_date', days=5000) }}
{% endif %}









