-- Этот анализ динамически считает количество рейсов по каждому уникальному коду самолёта
-- Использует Jinja для генерации SQL с динамическим списком aircraft_code

{%- set query %}  -- Jinja: определяем SQL-запрос для получения всех уникальных aircraft_code
select distinct aircraft_code
from {{ ref('fct_flights') }}  -- ref: подставляет имя модели fct_flights с учётом схемы
{%- endset %}

{%- set query_result = run_query(query) %}  -- Jinja: выполняем запрос выше и сохраняем результат
{%- if execute %}  -- Проверяем, выполняется ли код (а не просто компилируется)
    {%- set codes = query_result.columns[0].values() %}  -- Получаем список всех уникальных aircraft_code
{%- else %}
    {%- set codes = [] %}  -- Если не выполняется, создаём пустой список (для компиляции)
{%- endif %}

select
{%- for code in codes %}
    sum(case when aircraft_code = '{{ code }}' then 1 else 0 end) as flights_{{ code }}{% if not loop.last %},{% endif %}
{%- endfor %}
from {{ ref('fct_flights') }}