{%-set status_query %}
select distinct status
from {{ref('stg_flights__flights')}}
{%-endset %}
{%-set status_query_result = run_query(status_query) %}
{%-if execute %}
    {%-set statuses = status_query_result.columns[0].values() %}
{%-else %}
    {%-set statuses = [] %}
{%-endif %}
select 
{%-for status in statuses %}
    sum(case when status = '{{status}}' then 1 else 0 end) as "status_{{status}}"
    {%-if not loop.last %},{% endif %}
{%-endfor %}
from {{ref('stg_flights__flights')}}
