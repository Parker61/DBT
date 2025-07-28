-- Анализ: сводная таблица аэропортов вылета и статусов полетов
-- Используем dbt_utils.pivot для создания столбцов по статусам

select 
    departure_airport,
    {{ dbt_utils.pivot(
        column='status',
        values=dbt_utils.get_column_values(ref('fct_flights'), 'status'),
        prefix='',
        suffix='',
        then_value='1',
        else_value='0'
    ) }},
    count(*) as total_flights
from {{ ref('fct_flights') }}
group by departure_airport
order by departure_airport



