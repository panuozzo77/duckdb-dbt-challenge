WITH source AS (
    SELECT *
    FROM {{ ref('stg_trip__speed_filtered') }}
)

SELECT
    vendor_id,
    SUM(tip_amount) / NULLIF(SUM(total_amount), 0) AS tip_percentage
FROM source
GROUP BY vendor_id
ORDER BY tip_percentage
