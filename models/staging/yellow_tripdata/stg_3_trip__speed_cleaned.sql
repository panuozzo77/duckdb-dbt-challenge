WITH cleaned_trips AS (
    SELECT *
    FROM {{ ref('stg_2_trip__cleaned') }}
),

trips_with_duration_and_speed AS (
    SELECT
        *,
        DATEDIFF('second', pickup, dropoff) / 3600.0 AS trip_duration_hours
    FROM cleaned_trips
),

trips_with_avg_speed AS (
    SELECT
        *,
        trip_distance / NULLIF(trip_duration_hours, 0) AS avg_speed_mph
    FROM trips_with_duration_and_speed
)



SELECT
    *,
    trip_duration_hours,
    avg_speed_mph
FROM trips_with_avg_speed
WHERE
    avg_speed_mph BETWEEN 3 AND 80

ORDER BY avg_speed_mph, trip_distance 