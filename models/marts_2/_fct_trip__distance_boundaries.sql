WITH source AS (
    SELECT *
    FROM {{ ref('_dim_trip__distance_classifier') }}
)

SELECT
    distance_category,
    MIN(trip_distance) AS min_distance,
    MAX(trip_distance) AS max_distance,
    COUNT(*) AS number_of_trips
FROM source
GROUP BY distance_category
ORDER BY min_distance
