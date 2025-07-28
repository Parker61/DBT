{% macro limit_data_dev(column_name, days=5000) %}

{# Проверка, что days не отрицательное значение #}
{% if days < 0 %}
    {% do exceptions.raise_compiler_error("Invalid `days` of numeric. Got: " ~ days) %}
{% endif %}

{# Ограничение данных только для dev окружения #}
{% if target.name == 'dev' %}
WHERE
    {{ column_name }} >= {{ dbt.dateadd(datepart="day", interval=-days, from_date_or_timestamp="current_date") }}
{% endif %}
{% endmacro %}