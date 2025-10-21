-- esporre minutaggio, numero passeggeri, distanza delle corse

WITH normalized AS (
    SELECT
        trip_id,
        vendor_id,
        passenger_count,
        trip_distance,
        DATEDIFF('minute', pickup, dropoff) AS trip_minutes
    FROM {{ ref('stg_2_trip__cleaned') }}
)

SELECT *
FROM normalized

--ORDER BY trip_minutes desc