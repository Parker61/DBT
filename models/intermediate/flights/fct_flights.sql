{{ config(
    materialized='table'
) }}

SELECT
    {{ show_columns_relation(relation=ref('stg_flights__flights')) }}
FROM {{ ref('stg_flights__flights') }} 