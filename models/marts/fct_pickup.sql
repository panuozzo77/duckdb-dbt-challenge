WITH
pickup_zones AS (
    SELECT
        trip_id,
        start_location_id,
    FROM {{ ref('stg_trip__temporal_spatial') }}
),

revenues AS (
    SELECT
        trip_id,
        total_amount
    FROM {{ ref('stg_trip__prices_details') }}
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
    SUM(total_amount) AS total_revenue
FROM joined
GROUP BY pickup_zone
ORDER BY num_trips DESC
--         num_trips DESC

/*
Per ricavi:
Previewing node 'fct_pickup':
| pickup_zone | num_trips |   total_revenue |
| ----------- | --------- | --------------- |
|         132 |    158649 | 12.788.400,880… |
|         138 |     90371 |  6.183.293,020… |
|         161 |    114964 |  2.912.900,650… |
|         186 |     97539 |  2.508.443,760… |
|         230 |     81998 |  2.382.508,970… |

Per tratte:
Previewing node 'fct_pickup':
| pickup_zone | num_trips |   total_revenue |
| ----------- | --------- | --------------- |
|         132 |    158649 | 12.788.400,880… |
|         161 |    114964 |  2.912.900,650… |
|         237 |    106781 |  2.207.805,970… |
|         186 |     97539 |  2.508.443,760… |
|         138 |     90371 |  6.183.293,020… |
*/