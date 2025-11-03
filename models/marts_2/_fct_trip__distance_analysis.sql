WITH source AS (
    SELECT *
    FROM {{ ref('_dim_trip__distance_classifier') }}
)

SELECT
    distance_category,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_revenue,
    AVG(trip_minutes) AS avg_duration,
    COUNT(*) AS total_trips,
    (AVG(total_amount) / NULLIF(AVG(trip_minutes), 0)) AS dollar_per_min
FROM source
GROUP BY distance_category
ORDER BY total_revenue
