{% macro log_statuses_to_db(table_name, column_name='status') %}
    {# Макрос для записи уникальных значений статусов в таблицу dbt_logs #}
    {# Параметры: #}
    {#   table_name: название таблицы для анализа #}
    {#   column_name: название колонки со статусами (по умолчанию 'status') #}
    
    {% set status_values = dbt_utils.get_column_values(
        table=table_name,
        column=column_name
    ) %}
    
    {% set statuses_string = status_values | join(", ") %}
    
    {% do log('Уникальные статусы полетов: ' ~ status_values, info=True) %}
    
    INSERT INTO {{ target.database }}.logs.dbt_logs
    (event_date, event_name, node_name)
    VALUES (
        CURRENT_TIMESTAMP, '{{ statuses_string }}', '{{ this.name }}'
    );
{% endmacro %} 