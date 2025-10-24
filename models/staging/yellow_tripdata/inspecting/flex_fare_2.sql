WITH flex_fare_trips AS (
    SELECT
        *,
        DATEDIFF('minute', pickup, dropoff) AS trip_duration_minutes
    FROM {{ ref('stg_trip__base') }}
    WHERE
        payment_type = 0
)

SELECT
    'Total Flex Fare Trips' AS check_description,
    COUNT(*) AS record_count
FROM flex_fare_trips

UNION ALL

SELECT
    'Violating: total_amount <= 0' AS check_description,
    COUNT(*) AS record_count
FROM flex_fare_trips
WHERE total_amount <= 0

UNION ALL

SELECT
    'Violating: trip_distance <= 0' AS check_description,
    COUNT(*) AS record_count
FROM flex_fare_trips
WHERE trip_distance <= 0

UNION ALL

SELECT
    'Violating: passenger_count <= 0' AS check_description,
    COUNT(*) AS record_count
FROM flex_fare_trips
WHERE passenger_count <= 0

UNION ALL

SELECT
    'Violating: Invalid Duration' AS check_description,
    COUNT(*) AS record_count
FROM flex_fare_trips
WHERE NOT (trip_duration_minutes BETWEEN 1 AND 1440)

UNION ALL

SELECT
    'Violating: total_amount < fare_amount' AS check_description,
    COUNT(*) AS record_count
FROM flex_fare_trips
WHERE total_amount < fare_amount