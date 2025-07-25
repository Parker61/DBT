
{% set stg_flights__flights = api.Relation.create(
      database = 'dwh_flights',
      schema = 'intermediate',
      identifier = 'stg_flights__flights',
      type = 'table'
    ) 
%}

{% for column in adapter.get_columns_in_relation(stg_flights__flights) %}
    {{ 'Column: ' ~ column }}
{%- endfor %} 