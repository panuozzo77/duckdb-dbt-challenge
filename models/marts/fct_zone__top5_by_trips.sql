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
ORDER BY num_trips DESC
LIMIT 5