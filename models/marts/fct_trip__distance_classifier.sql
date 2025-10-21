/*
trip_id,
        vendor_id,
        passenger_count,
        trip_distance,
        DATEDIFF('minute', pickup, dropoff) AS trip_minutes
*/
WITH cleaned_trips AS (
    SELECT
        trip_id,
        vendor_id,
        passenger_count,
        trip_distance,
        trip_minutes,
    FROM {{ ref('stg_trip__metrics') }}
    --WHERE trip_distance > 0
),

distance_segmentation AS (
    SELECT
        *,
        NTILE(3) OVER (ORDER BY trip_distance) AS distance_fract
    FROM cleaned_trips
)

SELECT
    trip_id,
    vendor_id,
    passenger_count,
    trip_distance,
    trip_minutes,
    CASE
        WHEN distance_fract = 1 THEN 'short'
        WHEN distance_fract = 2 THEN 'medium'
        WHEN distance_fract = 3 THEN 'long'
    END AS distance_category
FROM distance_segmentation

ORDER BY trip_distance DESC

/*
Previewing node 'fct_trip__distance_classifier':
| trip_id              | vendor_id | passenger_count | trip_distance | trip_minutes | distance_category |
| -------------------- | --------- | --------------- | ------------- | ------------ | ----------------- |
| b36b85e4454e76306... |         2 |               1 |      3.900,78 |           12 | long              |
| 02ccda5ccb41407ae... |         2 |               3 |        338,25 |          339 | long              |
| 8598649c589182723... |         2 |               1 |        310,43 |           12 | long              |
| 7bc65659c116f5383... |         1 |               1 |        302,40 |           29 | long              |
| 233a6d04fa04f866f... |         2 |               1 |        302,16 |          292 | long              |
*/
