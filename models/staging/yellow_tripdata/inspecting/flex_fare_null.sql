WITH flex_fare_trips AS (
    SELECT *
    FROM {{ ref('stg_trip__base') }}
    WHERE payment_type = 0
)

SELECT
    'Total Flex Fare Trips' AS metric,
    COUNT(*) AS count
FROM flex_fare_trips

UNION ALL

SELECT
    'NULLs in total_amount' AS metric,
    COUNT_IF(total_amount IS NULL) AS count
FROM flex_fare_trips

UNION ALL

SELECT
    'NULLs in fare_amount' AS metric,
    COUNT_IF(fare_amount IS NULL) AS count
FROM flex_fare_trips

UNION ALL

SELECT
    'NULLs in trip_distance' AS metric,
    COUNT_IF(trip_distance IS NULL) AS count
FROM flex_fare_trips

UNION ALL

SELECT
    'NULLs in passenger_count' AS metric,
    COUNT_IF(passenger_count IS NULL) AS count
FROM flex_fare_trips

UNION ALL

SELECT
    'NULLs in pickup datetime' AS metric,
    COUNT_IF(pickup IS NULL) AS count
FROM flex_fare_trips

UNION ALL

SELECT
    'NULLs in dropoff datetime' AS metric,
    COUNT_IF(dropoff IS NULL) AS count
FROM flex_fare_trips