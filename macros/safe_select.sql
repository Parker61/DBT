{% macro safe_select(table_name) %}
    {# Безопасный SELECT с проверкой существования таблицы #}
    {# Параметры: #}
    {#   table_name: название таблицы для проверки #}
    
    {% set check_query %}
        SELECT EXISTS (
            SELECT 1 
            FROM information_schema.tables 
            WHERE table_schema = '{{ target.schema }}' 
            AND table_name = '{{ table_name }}'
        ) as table_exists
    {% endset %}
    
    {% set result = run_query(check_query) %}
    
    {% if execute %}
        {% set exists = result.columns[0].values()[0] %}
        
        {% if exists %}
            SELECT * FROM {{ target.database }}.{{ target.schema }}.{{ table_name }}
        {% else %}
            SELECT NULL as safe_select_result
        {% endif %}
    {% else %}
        SELECT NULL as safe_select_result
    {% endif %}
{% endmacro %}