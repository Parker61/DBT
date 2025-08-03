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
    {{ bookref_to_bigint('book_ref') }} > (SELECT MAX({{ bookref_to_bigint('book_ref') }}) FROM {{ this }})
    {% if target.name == 'dev' %}
    AND book_date >= {{ dbt.dateadd(datepart="day", interval=-5000, from_date_or_timestamp="current_date") }}
    {% endif %}
{% else %}
    {{ limit_data_dev(column_name='book_date', days=5000) }}
{% endif %}









