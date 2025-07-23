{{ config(
    materialized='incremental', 
    unique_key='flight_id', 
    incremental_strategy='merge', 
    merge_exclude_columns=['aircraft_code']
) }}

SELECT
    flight_id,
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    departure_airport,
    arrival_airport,
    status,
    aircraft_code,
    actual_departure,
    actual_arrival
FROM {{ source('demo_src', 'flights') }} AS src
{% if is_incremental() %}
    WHERE src.scheduled_departure >= (
        SELECT MAX(scheduled_departure) - INTERVAL '100 days'
        FROM {{ this }}
    )
{% endif %}