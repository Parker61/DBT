{{ config(
    materialized='table'
) }}

SELECT 
book_ref,
 book_date, 
 total_amount
FROM {{ ref('stg_flights__booking') }}