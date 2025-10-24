WITH normalized AS (
    SELECT
        trip_id,
        vendor_id,
        pickup,
        dropoff,
        start_location_id,
        end_location_id
    FROM {{ ref('stg_3_trip__speed_cleaned') }}
)

SELECT *
FROM normalized