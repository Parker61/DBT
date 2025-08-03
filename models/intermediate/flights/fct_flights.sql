{{ config(
    materialized='table',
    post_hook=[
        """
        INSERT INTO {{ target.database }}.logs.dbt_logs
        (event_date, event_name, node_name)
        VALUES (
            CURRENT_TIMESTAMP, 'status_analysis', '{{ this.name }}'
        );
        """,
        "{{ log_statuses_to_db(table_name=this, column_name='status') }}"
    ]
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
    actual_arrival,
    case
        when actual_departure is not null and scheduled_departure < actual_departure
        then actual_departure - scheduled_departure
        else INTERVAL '0 seconds'
    end as flight_departure_delay
FROM {{ ref('stg_flights__flights') }}
order by  flight_departure_delay desc