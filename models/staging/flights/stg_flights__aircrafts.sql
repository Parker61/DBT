{{ config(
    materialized = 'table',
    pre_hook = "{% set backup_timestamp = run_started_at.strftime('%Y_%m_%d_%H%M%S') %}
    {% set backup_identifier = this.identifier ~ '_backup_' ~ backup_timestamp %}
    {% if adapter.get_relation(this.database, this.schema, this.identifier) %}
    {% do adapter.create_schema(api.Relation.create(database=this.database, schema='backup')) %}CREATE TABLE backup.{{ backup_identifier }} AS SELECT * FROM {{ this }};{% endif %}"
) }}

select 
    aircraft_code,
    model,
    "range"
from {{ source('demo_src', 'aircrafts') }}