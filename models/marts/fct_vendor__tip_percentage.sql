WITH prices AS (
    SELECT
        vendor_id,
        tip_amount,
        total_amount
        FROM {{ ref('int_trip__prices')}}
)

SELECT 
    vendor_id,
    TRY_CAST(SUM(tip_amount) / SUM(total_amount) AS DECIMAL(10, 2)) AS tip_percentage,
FROM prices
GROUP BY vendor_id
ORDER BY tip_percentage