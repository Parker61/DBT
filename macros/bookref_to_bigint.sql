{% macro bookref_to_bigint(column_name) %}
    ('0x' || {{ column_name }})::bigint
{% endmacro %}