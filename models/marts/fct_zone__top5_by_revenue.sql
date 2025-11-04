WITH source AS (
    SELECT
        *
    FROM {{ ref('int_zone__pickup_summary') }}
)

SELECT
    pickup_zone,
    num_trips,
    TRY_CAST(total_revenue AS DECIMAL(10, 2)) AS total_revenue
FROM source
ORDER BY total_revenue DESC
LIMIT 5