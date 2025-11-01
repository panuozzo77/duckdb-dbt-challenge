WITH
pickup_zones AS (
    SELECT
        trip_id,
        start_location_id,
    FROM {{ ref('int_trip__temporal_spatial') }}
),

revenues AS (
    SELECT
        trip_id,
        total_amount
    FROM {{ ref('int_trip__prices') }}
),

joined AS (
    SELECT 
        pickup_zones.start_location_id AS pickup_zone,
        revenues.total_amount
    FROM pickup_zones
    JOIN revenues ON pickup_zones.trip_id = revenues.trip_id
)

SELECT
    pickup_zone,
    COUNT(*) AS num_trips,
    SUM(total_amount) AS total_revenue
FROM joined
GROUP BY pickup_zone