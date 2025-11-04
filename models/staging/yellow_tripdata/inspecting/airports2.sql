{{ config(
    tags=['inspecting']
)}}

WITH short_trips AS (
    SELECT
        CASE
            WHEN start_location_id = 132 THEN 'JFK'
            WHEN start_location_id = 138 THEN 'LGA'
            ELSE 'Other'
        END AS airport,
        DATEDIFF('minute', pickup, dropoff) AS duration_min,
        trip_distance
    FROM {{ ref('stg_trip__speed_filtered') }}
    WHERE start_location_id IN (132, 138)
      -- AND DATEDIFF('minute', pickup, dropoff) <= 2
      AND DATEDIFF('minute', pickup, dropoff) BETWEEN 100 AND 210
)

SELECT
    airport,
    COUNT(*) AS short_trip_count,
    ROUND(AVG(trip_distance), 3) AS avg_distance_miles,
    MIN(trip_distance) AS min_distance_miles,
    MAX(trip_distance) AS max_distance_miles
FROM short_trips
GROUP BY airport
ORDER BY airport

/*

('stg_trip__speed_filtered')
meno di 2 minuti

| airport | short_trip_count | avg_distance_miles | min_distance_miles | max_distance_miles |
| ------- | ---------------- | ------------------ | ------------------ | ------------------ |
| JFK     |              334 |              0,508 |               0,06 |               1,91 |
| LGA     |               98 |              0,465 |               0,08 |               1,13 |

meno di 1 minuto

Previewing node 'airports2':
| airport | short_trip_count | avg_distance_miles | min_distance_miles | max_distance_miles |
| ------- | ---------------- | ------------------ | ------------------ | ------------------ |
| JFK     |              126 |              0,333 |               0,06 |               1,53 |
| LGA     |               37 |              0,376 |               0,08 |               1,00 |

('stg_trip__cleaned')

meno di 2 minuti
Previewing node 'airports2':
| airport | short_trip_count | avg_distance_miles | min_distance_miles | max_distance_miles |
| ------- | ---------------- | ------------------ | ------------------ | ------------------ |
| JFK     |              817 |              0,373 |               0,01 |               20,1 |
| LGA     |              238 |              0,318 |               0,01 |               10,1 |

meno di 1 minuto

Previewing node 'airports2':
| airport | short_trip_count | avg_distance_miles | min_distance_miles | max_distance_miles |
| ------- | ---------------- | ------------------ | ------------------ | ------------------ |
| JFK     |              588 |              0,300 |               0,01 |               20,1 |
| LGA     |              174 |              0,253 |               0,01 |               10,1 |

---

AND DATEDIFF('minute', pickup, dropoff) BETWEEN 100 AND 210

| airport | short_trip_count | avg_distance_miles | min_distance_miles | max_distance_miles |
| ------- | ---------------- | ------------------ | ------------------ | ------------------ |
| JFK     |              665 |             37,513 |               7,34 |             172,93 |
| LGA     |               52 |             31,978 |               6,90 |             127,15 |
*/