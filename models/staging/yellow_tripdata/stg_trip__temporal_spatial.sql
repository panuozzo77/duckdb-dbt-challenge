WITH normalized AS (
    SELECT
        vendor_id,
        pickup,
        dropoff,
        start_location_id,
        end_location_id
    FROM {{ ref('stg_yellow_tripdata__cleaned') }}
)

SELECT *
FROM normalized