-- pulizia dei dati
WITH source AS (
    SELECT *
    FROM {{ ref('stg_1_trip__normalized') }}
)
SELECT *
FROM source
WHERE
    trip_distance >= 0
    AND total_amount > 0
    -- un viaggio deve avere almeno un passeggero
    AND passenger_count > 0
    AND DATEDIFF('minute', pickup, dropoff) BETWEEN 1 AND 24 * 60

    -- campi che hanno un elenco di valori ammissibili, come da PDF
    AND vendor_id IN (1, 2, 6, 7)
    AND rate_code_id IN (1, 2, 3, 4, 5, 6, 99)
    AND store_and_fwd_flag IN ('Y', 'N')
    AND payment_type IN (0, 1, 2, 3, 4, 5, 6)
