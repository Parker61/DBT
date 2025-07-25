
SELECT
    airport_code,
    airport_name,
    city,
    coordinates,
    timezone,
    COUNT(*) as {{ adapter.quote('airport_code') }}

FROM
    {{ source('demo_src', 'airports') }}
group by 1