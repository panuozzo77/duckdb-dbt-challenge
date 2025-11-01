-- esporre minutaggio, numero passeggeri, distanza delle corse

WITH normalized AS (
    SELECT
        trip_id,
        vendor_id,
        passenger_count,
        trip_distance,
        trip_duration_hours*60 AS trip_minutes
    FROM {{ ref('stg_trip__speed_filtered') }}
)

SELECT *
FROM normalized

--ORDER BY trip_minutes desc