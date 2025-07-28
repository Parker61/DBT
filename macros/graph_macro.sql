{% macro count_project_objects() %}
{# Макрос для подсчета объектов проекта: моделей, seeds, snapshots #}

{% if execute %}
    {# Подсчитываем количество каждого типа объектов #}
    {% set models_count = graph.nodes.values() | selectattr("resource_type", "equalto", "model") | list | length %}
    {% set seeds_count = graph.nodes.values() | selectattr("resource_type", "equalto", "seed") | list | length %}
    {% set snapshots_count = graph.nodes.values() | selectattr("resource_type", "equalto", "snapshot") | list | length %}
    
    {# Выводим результат в логи #}
    {% do log("Всего в проекте:", info=True) %}
    {% do log("- " ~ models_count ~ " моделей", info=True) %}
    {% do log("- " ~ seeds_count ~ " seed", info=True) %}
    {% do log("- " ~ snapshots_count ~ " snapshot", info=True) %}
{% endif %}

{% endmacro %}



