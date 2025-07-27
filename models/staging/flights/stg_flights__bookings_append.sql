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
WHERE 
    {{ bookref_to_bigint(column_name='book_ref') }} > (SELECT MAX(book_ref_bigint) FROM {{ this }})
{% endif %}