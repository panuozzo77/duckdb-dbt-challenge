WITH source AS (
    SELECT
        *
    FROM {{ ref('fct_zone__pickup_summary') }}
)

SELECT
    pickup_zone,
    num_trips,
    total_revenue
FROM source
ORDER BY total_revenue DESC
LIMIT 5