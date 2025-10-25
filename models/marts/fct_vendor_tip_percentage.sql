WITH prices AS (
    SELECT
        vendor_id,
        tip_amount,
        total_amount
        FROM {{ ref('stg_trip__prices')}}
)

SELECT 
    vendor_id,
    SUM(tip_amount) / SUM(total_amount) AS tip_percentage,
FROM prices
GROUP BY vendor_id
ORDER BY tip_percentage