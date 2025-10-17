WITH source AS (
    SELECT *
    FROM {{ ref('raw_data') }}
)

SELECT
    "VendorID" AS vendor_id,
    tpep_pickup_datetime as pickup,
    tpep_dropoff_datetime as dropoff,
    "RatecodeID" AS rate_code_id,
    store_and_fwd_flag,
    "PULocationID" AS start_location_id,
    "DOLocationID" AS end_location_id,
    passenger_count,
    trip_distance,
    "fare_amount" AS fare_amount,
    "extra" AS extra,
    "mta_tax" AS mta_tax,
    "tip_amount" AS tip_amount,
    "tolls_amount" AS tolls_amount,
    "improvement_surcharge" AS improvement_surcharge,
    "congestion_surcharge" AS congestion_surcharge,
    "Airport_fee" AS airport_fee,
    "payment_type" AS payment_type,
    "total_amount" AS total_amount
FROM source