-- Анализ: количество рейсов за последние 10 лет по дате вылета

{%- set current_date = run_started_at | string | truncate(10, True, "") %}
{%- set current_year = run_started_at.year %}
{%- set prev_year = current_year - 10 %}
{%- set prev_date = (current_date[:4] | int - 10) ~ current_date[4:] %}

select
    scheduled_departure::date as scheduled_departure,
    count(*) as flights_count
from {{ ref('fct_flights') }}
where scheduled_departure between
    '{{ prev_date }}'::date
    and
    '{{ current_date }}'::date
group by scheduled_departure::date
order by scheduled_departure::date






