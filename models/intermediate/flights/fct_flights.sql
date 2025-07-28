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
    {{ show_columns_relation(relation=ref('stg_flights__flights')) }}
FROM {{ ref('stg_flights__flights') }} 