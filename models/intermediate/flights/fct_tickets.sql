{{ config(
    materialized='table'
) }}

SELECT 
    ticket_no,
    book_ref,
    passenger_id,
    passenger_name,
    contact_data
FROM {{ ref('stg_flights__tickets') }} 
where passenger_id not in (select passenger_id from {{ ref('id_passenger') }})