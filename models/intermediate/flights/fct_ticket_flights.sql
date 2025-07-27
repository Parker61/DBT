{{ config(
    materialized = 'table'
) }}

SELECT 
    ticket_no,
    flight_id,
    fare_conditions,
    amount
FROM {{ ref('stg_flights__ticket_flights') }}