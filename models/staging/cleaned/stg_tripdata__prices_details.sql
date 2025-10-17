-- composizione del prezzo della corsa

WITH normalized AS (
    SELECT
        vendor_id,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        congestion_surcharge,
        airport_fee,
        total_amount
    FROM {{ ref('stg_tripdata__normalized') }}
)

SELECT *
FROM normalized