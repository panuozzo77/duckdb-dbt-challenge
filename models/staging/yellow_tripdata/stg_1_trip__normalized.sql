WITH source AS (
    SELECT *
    FROM {{ source('main', 'raw_data')}}
)

SELECT
    vendorid AS vendor_id,
    tpep_pickup_datetime as pickup,
    tpep_dropoff_datetime as dropoff,
    ratecodeid AS rate_code_id,
    store_and_fwd_flag,
    pulocationid AS start_location_id,
    dolocationid AS end_location_id,
    passenger_count,
    trip_distance,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    congestion_surcharge,
    airport_fee,
    payment_type,
    total_amount
FROM source