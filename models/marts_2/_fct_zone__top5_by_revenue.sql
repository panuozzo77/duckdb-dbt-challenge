WITH source AS (
    SELECT *
    FROM {{ ref('stg_trip__speed_filtered') }}
)

SELECT
    start_location_id AS pickup_zone,
    COUNT(*) AS num_trips,
    SUM(total_amount) AS total_revenue
FROM source
GROUP BY pickup_zone
ORDER BY total_revenue DESC
LIMIT 5
