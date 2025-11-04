{{ config(
    tags=['inspecting']
)}}

WITH raw_data AS (
    SELECT *
    FROM "yellow_tripdata"."main"."stg_trip__base"
    WHERE vendor_id IN (1, 2, 6, 7)
),

null_inspection AS (
    SELECT
        vendor_id,
        -- Contiamo i NULL per ogni campo critico usato nel WHERE di dbt
        SUM(CASE WHEN payment_type IS NULL THEN 1 ELSE 0 END) AS null_payment_type,
        SUM(CASE WHEN total_amount IS NULL THEN 1 ELSE 0 END) AS null_total_amount,
        SUM(CASE WHEN passenger_count IS NULL THEN 1 ELSE 0 END) AS null_passenger_count,
        SUM(CASE WHEN pickup IS NULL THEN 1 ELSE 0 END) AS null_pickup,
        SUM(CASE WHEN dropoff IS NULL THEN 1 ELSE 0 END) AS null_dropoff,
        SUM(CASE WHEN trip_distance IS NULL THEN 1 ELSE 0 END) AS null_trip_distance,
        SUM(CASE WHEN fare_amount IS NULL THEN 1 ELSE 0 END) AS null_fare_amount,
        -- Aggiunga qui altri campi monetari se necessario (extra, mta_tax, etc.)
        
        COUNT(*) AS total_raw_trips
    FROM raw_data
    GROUP BY 1
)

SELECT * FROM null_inspection