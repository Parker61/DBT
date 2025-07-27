{{ config(
    materialized = 'table'
) }}

SELECT
    {{ show_columns_relation(relation=ref('stg_flights__booking')) }}
FROM {{ ref('stg_flights__booking') }} 