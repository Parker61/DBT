There are 1 unused configuration paths:
- models.dbt_study.marts
{{ config(materialized='table') }}

with source as (

    select * from {{ source('demo_src', 'aircrafts') }}

),

renamed as (

    select
        aircraft_code,
        model,
        range

    from source

)

select * from renamed

