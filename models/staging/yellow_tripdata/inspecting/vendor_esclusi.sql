WITH raw_data AS (
    SELECT
        *,
        (epoch(tpep_dropoff_datetime) - epoch(tpep_pickup_datetime)) / 60.0 AS trip_duration_minutes,
        fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee AS calculated_total_amount
    FROM 'data/raw/yellow_tripdata_2025-08.parquet'
    WHERE VendorID IN (1, 2, 6, 7)
),

exclusion_counts AS (
    SELECT
        VendorID,
        SUM(CASE WHEN payment_type IN (4, 5, 6) THEN 1 ELSE 0 END) AS failed_payment_type_check,
        
        SUM(CASE WHEN total_amount < (calculated_total_amount - 0.01) THEN 1 ELSE 0 END) AS failed_amount_coherence_check,

        SUM(CASE WHEN passenger_count <= 0 THEN 1 ELSE 0 END) AS failed_passenger_count_check,
        SUM(CASE WHEN trip_duration_minutes < 1 OR trip_duration_minutes > (3.5 * 60) THEN 1 ELSE 0 END) AS failed_duration_check,
        SUM(CASE WHEN trip_distance <= 0 THEN 1 ELSE 0 END) AS failed_distance_check,
        SUM(CASE WHEN NOT (total_amount > 0 OR (total_amount = 0 AND payment_type IN (2, 3))) THEN 1 ELSE 0 END) AS failed_total_amount_logic_check,
        
        COUNT(*) AS total_raw_trips
    FROM raw_data
    GROUP BY 1
)

SELECT * FROM exclusion_counts