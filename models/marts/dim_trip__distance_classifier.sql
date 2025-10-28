/*
trip_id,
        vendor_id,
        passenger_count,
        trip_distance,
        DATEDIFF('minute', pickup, dropoff) AS trip_minutes
*/
WITH cleaned_trips AS (
    SELECT
        trip_id,
        vendor_id,
        passenger_count,
        trip_distance,
        trip_minutes,
    FROM {{ ref('stg_trip__metrics') }}
)

/*
distance_segmentation AS (
    SELECT
        *,
        NTILE(3) OVER (ORDER BY trip_distance) AS distance_fract
    FROM cleaned_trips
)
*/

SELECT
    trip_id,
    vendor_id,
    passenger_count,
    trip_distance,
    trip_minutes,
    CASE
        WHEN trip_distance <= 2 THEN 'short'
        WHEN trip_distance > 2 AND trip_distance <= 5  THEN 'medium'
        WHEN trip_distance > 5 THEN 'long'
    END AS distance_category
FROM cleaned_trips

ORDER BY trip_minutes ASC , trip_distance DESC

/*
Previewing node 'fct_trip__distance_classifier':
| trip_id              | vendor_id | passenger_count | trip_distance | trip_minutes | distance_category |
| -------------------- | --------- | --------------- | ------------- | ------------ | ----------------- |
| b36b85e4454e76306... |         2 |               1 | !!!  3.900,78 |    ! ! !  12 | long              |
| 02ccda5ccb41407ae... |         2 |               3 |        338,25 |          339 | long              |
| 8598649c589182723... |         2 |               1 |        310,43 |           12 | long              |
| 7bc65659c116f5383... |         1 |               1 |        302,40 |           29 | long              |
| 233a6d04fa04f866f... |         2 |               1 |        302,16 |          292 | long              |

Previewing node 'fct_trip__distance_classifier':
| trip_id              | vendor_id | passenger_count | trip_distance | trip_minutes | distance_category |
| -------------------- | --------- | --------------- | ------------- | ------------ | ----------------- |
| 267034eb2082e845e... |         2 |               1 |          0,16 |   ! ! ! 6988 | short             |
| f0d36899d7f8e5f3f... |         2 |               1 |          7,39 |         4359 | long              |
| 483ed561b171d4275... |         2 |               1 |          0,97 |         4280 | short             |
| 460de06673315d0d5... |         2 |               1 |         11,61 |         4190 | long              |
| cbbcb211ceed487aa... |         1 |               1 |         12,10 |         4188 | long              |

la mia idea è di creare degli scaglioni di 3-5km (esagerando, con orari e posizioni di partenza e arrivo similari), inserire i valori di distanza e minutaggio dentro una curva di distribuzione 
ed i valori che si discostano troppo vengono scartati in quanto non sono plausibili.

Non ho idea di come si faccia in SQL ^

alternativamente, si calcola la velocità media e se questa supera una certa velocità, è da scartare. Se invece è una velocità troppo bassa... quanto bassa?

*/
