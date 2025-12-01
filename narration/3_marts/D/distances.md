#### D. **Distance Analysis** [Mandatory]
- Segment trips by distance (`trip_distance`):
  - **Short**: 0-2 miles.
  - **Medium**: 2-5 miles.
  - **Long**: >5 miles.
- Calculate the average trip duration and total revenue for each segment.

Molto simile al mart precedente dim_trip__distance_classifier... Credo sia stato volutamente proposto (guardacaso) proposto in [4_classify_by_distance](model_tasks/1/4_classify_by_distance.md)

Ho dovuto modificare nel modello dim_trip__distance_classifier i segmenti delle distanze delle corse perché precedentemente avevo impostato delle soglie 'personali'

e così calcolare la media dei guadagni

```sql
WITH revenues AS(
    SELECT * 
    FROM {{ref('int_trip__prices')}}
),

distances AS(
    SELECT *
    FROM {{ ref('dim_trip__distance_classifier')}}
)

SELECT
    distance_category,
    TRY_CAST(SUM(total_amount) AS DECIMAL(10, 2)) AS total_revenue,
    TRY_CAST(SUM(total_amount) / COUNT (*) AS DECIMAL(10, 2)) AS avg_revenue,
    TRY_CAST(SUM(trip_minutes) / COUNT (*) AS DECIMAL(10, 2)) AS avg_duration,
    COUNT(*) AS total_trips,
    avg_revenue / avg_duration AS '$/min'
    FROM distances
    JOIN revenues ON distances.trip_id = revenues.trip_id 
    GROUP BY distance_category
    ORDER BY total_revenue
```

Previewing node 'fct_trip__distance_analysis':
| distance_category |   total_revenue | avg_revenue | avg_duration | total_trips |
| ----------------- | --------------- | ----------- | ------------ | ----------- |
| long              | 16.709.874,600… |     93,065… |      51,467… |      179551 |
| medium            | 24.460.742,740… |     42,806… |      25,380… |      571426 |
| short             | 32.164.149,000… |     19,175… |      10,335… |     1677368 |