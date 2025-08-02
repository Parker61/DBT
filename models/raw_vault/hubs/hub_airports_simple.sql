{{ config(materialized='incremental') }}

WITH source_data AS (
    SELECT DISTINCT
        AIRPORT_HK,
        airport_code,
        LOAD_DATETIME,
        SOURCE
    FROM {{ ref('v_stg_flights__airports') }}
)

SELECT 
    AIRPORT_HK,
    airport_code,
    LOAD_DATETIME,
    SOURCE
FROM source_data

{% if is_incremental() %}
WHERE LOAD_DATETIME > (SELECT MAX(LOAD_DATETIME) FROM {{ this }})
{% endif %} 