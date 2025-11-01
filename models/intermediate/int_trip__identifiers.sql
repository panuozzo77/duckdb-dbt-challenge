-- tutti gli identificatori

WITH normalized AS (
    SELECT
        trip_id,
        vendor_id,
        rate_code_id,
        store_and_fwd_flag,
        payment_type
    FROM {{ ref('stg_trip__speed_filtered') }}
)

SELECT *
FROM normalized