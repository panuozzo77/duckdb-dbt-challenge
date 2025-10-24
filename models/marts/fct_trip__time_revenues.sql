/*
temporal_spatial

WITH normalized AS (
    SELECT
        trip_id,
        vendor_id,
        pickup,
        dropoff,
        start_location_id,
        end_location_id
    FROM {{ ref('stg_trip__cleaned') }}
)

SELECT *
FROM normalized

prices_details

WITH normalized AS (
    SELECT
        trip_id,
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
    FROM {{ ref('stg_trip__cleaned') }}
)

SELECT *
FROM normalized
*/

WITH
time_zones AS (
    SELECT
        trip_id,
        pickup,
        dropoff,
        CASE
            WHEN EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) >= 5 AND EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) >= 12 AND EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) < 17 THEN 'Afternoon'
            WHEN EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) >= 17 AND EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) < 22 THEN 'Evening'
            WHEN EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) >= 22 AND EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) < 5 THEN 'Night'
            --ELSE 'Night'
        END AS time_of_day
    FROM {{ ref('stg_trip__temporal_spatial') }}
),

revenues AS (
    SELECT
        trip_id,
        total_amount
    FROM {{ ref('stg_trip__prices') }}
),

joined AS (
    SELECT 
        time_zones.time_of_day,
        revenues.total_amount
    FROM time_zones
    JOIN revenues ON time_zones.trip_id = revenues.trip_id
)

SELECT
    time_of_day as 'time',
    COUNT(*) AS n_trips,
    SUM(total_amount) AS total_revenue
FROM joined
GROUP BY time_of_day
ORDER BY
    CASE time_of_day
        WHEN 'Morning' THEN 1
        WHEN 'Afternoon' THEN 2
        WHEN 'Evening' THEN 3
        WHEN 'Night' THEN 4
    END

/*
Basato solo su fasce orarie e orario di partenza della corsa:
Previewing node 'fct_trip__time_revenues':
| time_of_day | total_trips |   total_revenue |
| ----------- | ----------- | --------------- |
| Morning     |      533988 | 15.289.146,040… |
| Afternoon   |      741254 | 22.831.627,620… |
| Evening     |      768831 | 23.309.074,930… |
|             |      384272 | 11.904.917,750… |

Usando l'orario medio tra inizio e fine:
Previewing node 'fct_trip__time_revenues':
| time      | n_trips |   total_revenue |
| --------- | ------- | --------------- |
| Morning   |  516724 | 14.565.522,920… |
| Afternoon |  733541 | 22.276.874,760… |
| Evening   |  778417 | 23.944.415,980… |
|           |  399663 | 12.547.952,680… |
*/