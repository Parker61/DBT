{% macro check_dependencies(node_name) %}
{# Макрос для проверки количества зависимостей текущей модели #}

{% if execute %}
    {# Получаем текущую модель из graph #}
    {% set current_model = graph.nodes.values() | selectattr("name", "equalto", node_name) | first %}
    
    {% if current_model %}
        {# Подсчитываем количество зависимостей #}
        {% set dependencies_count = current_model.depends_on.nodes | length %}
        
        {# Если модель зависит более чем от одного объекта, выводим предупреждение #}
        {% if dependencies_count > 1 %}
            {% do log("⚠️ Модель " ~ node_name ~ " зависит от " ~ dependencies_count ~ " объектов!", info=True) %}
        {% endif %}
    {% endif %}
{% endif %}

{% endmacro %}











