WITH normalized AS (
    SELECT
        vendor_id,
        pickup,
        dropoff,
        start_location_id,
        end_location_id
    FROM {{ ref('stg_tripdata__normalized') }}
)

SELECT *
FROM normalized