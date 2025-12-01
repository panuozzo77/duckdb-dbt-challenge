#### B. **Top 5 Pickup Zones** [Mandatory]
- Identify the top 5 pickup zones (`PULocationID`) with:
  - The highest number of trips.
  - The highest total revenue.

```sql
-- int_zone__pickup_summary
  WITH
pickup_zones AS (
    SELECT
        trip_id,
        start_location_id,
    FROM {{ ref('int_trip__temporal_spatial') }}
),

revenues AS (
    SELECT
        trip_id,
        total_amount
    FROM {{ ref('int_trip__prices') }}
),

joined AS (
    SELECT 
        pickup_zones.start_location_id AS pickup_zone,
        revenues.total_amount
    FROM pickup_zones
    JOIN revenues ON pickup_zones.trip_id = revenues.trip_id
)

SELECT
    pickup_zone,
    COUNT(*) AS num_trips,
    TRY_CAST(SUM(total_amount) AS DECIMAL(10, 2)) AS total_revenue
FROM joined
GROUP BY pickup_zone
```

---

```sql
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
```