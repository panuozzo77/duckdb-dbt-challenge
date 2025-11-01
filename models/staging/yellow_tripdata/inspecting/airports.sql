WITH airport_trips AS (
    SELECT
        CASE
            WHEN start_location_id = 132 THEN 'JFK'
            WHEN start_location_id = 138 THEN 'LGA'
            ELSE 'Other'
        END AS airport,
        DATEDIFF('minute', pickup, dropoff) AS trip_duration_minutes
    FROM {{ ref('stg_trip__cleaned') }}
    WHERE start_location_id IN (132, 138)
)

SELECT
    airport,
    COUNT(*) AS total_trips,
    ROUND(AVG(trip_duration_minutes), 2) AS avg_duration_min,
    MIN(trip_duration_minutes) AS min_duration_min,
    MAX(trip_duration_minutes) AS max_duration_min
FROM airport_trips
GROUP BY airport
ORDER BY total_trips DESC

/*
('stg_trip__speed_filtered') }}
| airport | total_trips | avg_duration_min | min_duration_min | max_duration_min |
| ------- | ----------- | ---------------- | ---------------- | ---------------- |
| JFK     |      158288 |            42,82 |                1 |              209 |
| LGA     |       90250 |            29,39 |                1 |              210 |

('stg_trip__cleaned')
Previewing node 'airports':
| airport | total_trips | avg_duration_min | min_duration_min | max_duration_min |
| ------- | ----------- | ---------------- | ---------------- | ---------------- |
| JFK     |      158875 |            42,69 |                1 |              209 |
| LGA     |       90436 |            29,35 |                1 |              210 |
*/