{% macro show_columns_relation(relation) %}
    {# Перечисление всех колонок из отношения #}
    {# Параметры: #}
    {#   relation: отношение (таблица/представление) для получения колонок #}
    
    {%- for column in adapter.get_columns_in_relation(relation) -%}
        {{ column.name }}{% if not loop.last %},{% endif %}
    {%- endfor -%}
{% endmacro %}