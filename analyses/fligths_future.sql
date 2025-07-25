-- Анализ: количество будущих рейсов, начиная с текущей даты запуска dbt

select
    '{{ run_started_at | string | truncate(10, True, "") }}' as current_date,  -- Текущая дата (YYYY-MM-DD)
    count(*) as flights_count
from {{ ref('fct_flights') }}
where scheduled_departure >= '{{ run_started_at | string | truncate(10, True, "") }}'



