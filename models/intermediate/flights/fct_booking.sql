{{ config(
    materialized='table'
) }}

SELECT 
    {{ dbt_utils.generate_surrogate_key(['book_ref']) }} as booking_key,
    book_ref,
    book_date, 
    total_amount
FROM {{ ref('stg_flights__booking') }}