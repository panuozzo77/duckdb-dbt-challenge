WITH source AS (
    SELECT *
    FROM {{ source('main', 'raw_data')}}
)

SELECT
    {{ dbt_utils.generate_surrogate_key([
        'vendorid',
        'tpep_pickup_datetime',
        'tpep_dropoff_datetime',
        'passenger_count',
        'trip_distance',
        'ratecodeid',
        'store_and_fwd_flag',
        'pulocationid',
        'dolocationid',
        'payment_type',
        'total_amount'
    ]) }} AS trip_id,
    
    TRY_CAST(vendorid AS INTEGER) AS vendor_id,
    TRY_CAST(tpep_pickup_datetime AS TIMESTAMP) as pickup,
    TRY_CAST(tpep_dropoff_datetime AS TIMESTAMP) as dropoff,
    TRY_CAST(ratecodeid AS INTEGER) AS rate_code_id,
    TRY_CAST(store_and_fwd_flag AS VARCHAR) AS store_and_fwd_flag,
    TRY_CAST(pulocationid AS INTEGER) AS start_location_id,
    TRY_CAST(dolocationid AS INTEGER) AS end_location_id,
    TRY_CAST(passenger_count AS INTEGER) AS passenger_count,
    TRY_CAST(trip_distance AS DOUBLE) AS trip_distance,
    TRY_CAST(fare_amount AS DECIMAL(10, 2)) AS fare_amount,
    TRY_CAST(extra AS DECIMAL(10, 2)) extra,
    TRY_CAST(mta_tax AS DECIMAL(10, 2)) AS mta_tax,
    TRY_CAST(tip_amount AS DECIMAL(10, 2)) AS tip_amount,
    TRY_CAST(tolls_amount AS DECIMAL(10, 2)) AS tolls_amount,
    TRY_CAST(improvement_surcharge AS DECIMAL(10, 2)) AS improvement_surcharge,
    TRY_CAST(congestion_surcharge AS DECIMAL(10, 2)) AS congestion_surcharge,
    TRY_CAST(airport_fee AS DECIMAL(10, 2)) AS airport_fee,
    TRY_CAST(payment_type AS INTEGER) AS payment_type, 
    TRY_CAST(total_amount AS DECIMAL(10, 2)) AS total_amount
FROM source