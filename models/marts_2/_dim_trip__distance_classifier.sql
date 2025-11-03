WITH source AS (
    SELECT *
    FROM {{ ref('stg_trip__speed_filtered') }}
)

SELECT
    total_amount,
    trip_id AS trip_id,
    vendor_id AS vendor_id,
    passenger_count AS passenger_count,
    trip_distance AS trip_distance,
    trip_duration_hours * 60 AS trip_minutes,
    CASE
        WHEN trip_distance <= 2 THEN 'short'
        WHEN trip_distance > 2 AND trip_distance <= 5 THEN 'medium'
        WHEN trip_distance > 5 THEN 'long'
    END AS distance_category
FROM source
