-- Анализ: количество рейсов за последние 10 лет по дате вылета

{%- set current_date = run_started_at | string | truncate(10, True, "") %}  -- Текущая дата (YYYY-MM-DD)
{%- set prev_date = (current_date[:4] | int - 10) ~ current_date[4:] %}        -- Дата 10 лет назад (YYYY-MM-DD)

select
    scheduled_departure::date as scheduled_departure,  -- Дата вылета (без времени)
    count(*) as flights_count                           -- Количество рейсов в этот день
from {{ ref('fct_flights') }}
where scheduled_departure between
    '{{ prev_date }}'::date
    and
    '{{ current_date }}'::date
group by scheduled_departure::date
order by scheduled_departure::date