{{ config(
    materialized='table'
) }}

SELECT *
FROM {{ ref('stg_flights__tickets') }} 