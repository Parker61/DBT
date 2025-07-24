SELECT 
    aircraft_code,
    COUNT(*) as seat_cnt
FROM
    {{ ref('stg_flights__seats') }}
GROUP BY
    aircraft_code
ORDER BY
    seat_cnt DESC