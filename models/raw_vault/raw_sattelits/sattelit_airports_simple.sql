{{ config(materialized='incremental') }}

WITH source_data AS (
    SELECT 
        AIRPORT_HK,
        AIRPORT_HASHDIFF,
        airport_name,
        city,
        coordinates,
        timezone,
        EFFECTIVE_FROM,
        LOAD_DATETIME,
        SOURCE
    FROM {{ ref('v_stg_flights__airports') }}
)

SELECT 
    AIRPORT_HK,
    AIRPORT_HASHDIFF,
    airport_name,
    city,
    coordinates,
    timezone,
    EFFECTIVE_FROM,
    LOAD_DATETIME,
    SOURCE
FROM source_data

{% if is_incremental() %}
WHERE LOAD_DATETIME > (SELECT MAX(LOAD_DATETIME) FROM {{ this }})
{% endif %} 