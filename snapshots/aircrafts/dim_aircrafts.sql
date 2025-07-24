{% snapshot dim_aircrafts %}
{{
    config(
        target_schema='snapshot',
        unique_key='aircraft_code',
        strategy='check',
        check_cols=['model', 'range'],
        dbt_valid_to_current="to_date('9999-12-31', 'YYYY-MM-DD')",
        hard_deletes='new_record',
        snapshot_meta_column_names={
        "dbt_valid_from": "start_date",
        "dbt_valid_to": "end_date",
        "dbt_scd_id": "scd_id",
        "dbt_updated_at": "modified_date",
        "dbt_is_deleted": "is_deleted",
      }

    )
}}

select 
    aircraft_code,
    model,
    "range"
from {{ ref('stg_flights__aircrafts') }}

{% endsnapshot %}