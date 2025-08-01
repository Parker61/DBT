[0m16:26:40  Running with dbt=1.10.4
[0m16:26:40  Registered adapter: postgres=1.9.0
[0m16:26:42  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 1 unused configuration paths:
- models.dbt_study.marts
[0m16:26:42  Found 19 models, 4 snapshots, 16 analyses, 2 seeds, 14 data tests, 8 sources, 583 macros
{{ config(materialized='table') }}

with source as (

    select * from {{ source('demo_src', 'flights') }}

),

renamed as (

    select
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

    from source

)

select * from renamed

