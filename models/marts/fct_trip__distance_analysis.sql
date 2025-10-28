WITH revenues AS(
    SELECT * 
    FROM {{ref('stg_trip__prices')}}
),

distances AS(
    SELECT *
    FROM {{ ref('dim_trip__distance_classifier')}}
)

SELECT
    distance_category,
    SUM(total_amount) AS total_revenue,
    SUM(total_amount) / COUNT (*) AS avg_revenue,
    SUM(trip_minutes) / COUNT (*) AS avg_duration,
    COUNT(*) AS total_trips,
    avg_revenue / avg_duration AS '$/min'
    FROM distances
    JOIN revenues ON distances.trip_id = revenues.trip_id 
    GROUP BY distance_category
    ORDER BY total_revenue

/*
Previewing node 'fct_trip__distance_analysis':
| distance_category |   total_revenue | avg_revenue | avg_duration | total_trips |
| ----------------- | --------------- | ----------- | ------------ | ----------- |
| long              | 16.709.874,600… |     93,065… |      51,467… |      179551 |
| medium            | 24.460.742,740… |     42,806… |      25,380… |      571426 |
| short             | 32.164.149,000… |     19,175… |      10,335… |     1677368 |
*/