{{ config(materialized='table') }}

-- Тестовая модель для проверки макроса safe_select

-- Тест 1: Существующая таблица
{{ safe_select(table_name='stg_flights__flights') }} 