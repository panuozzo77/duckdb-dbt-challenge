WITH source AS (
    SELECT *
    FROM {{ ref('stg_trip__speed_filtered') }}
)

SELECT
    CASE
       WHEN EXTRACT(HOUR FROM (pickup + (dropoff - pickup) / 2)) >= 5
           AND EXTRACT(HOUR FROM (pickup + (dropoff - pickup) / 2)) < 12 THEN 'Morning'
       WHEN EXTRACT(HOUR FROM (pickup + (dropoff - pickup) / 2)) >= 12
           AND EXTRACT(HOUR FROM (pickup + (dropoff - pickup) / 2)) < 17 THEN 'Afternoon'
       WHEN EXTRACT(HOUR FROM (pickup + (dropoff - pickup) / 2)) >= 17
           AND EXTRACT(HOUR FROM (pickup + (dropoff - pickup) / 2)) < 22 THEN 'Evening'
       ELSE 'Night'
    END AS time_of_day,

    COUNT(*) AS n_trips,
    SUM(total_amount) AS total_revenue

FROM source

GROUP BY 1
ORDER BY
    CASE
        WHEN time_of_day = 'Morning' THEN 1
        WHEN time_of_day = 'Afternoon' THEN 2
        WHEN time_of_day = 'Evening' THEN 3
        WHEN time_of_day = 'Night' THEN 4
        ELSE 5
    END

/*
Basato solo su fasce orarie e orario di partenza della corsa:
Previewing node 'fct_trip__time_revenues':
| time_of_day | total_trips |   total_revenue |
| ----------- | ----------- | --------------- |
| Morning     |      533988 | 15.289.146,040… |
| Afternoon   |      741254 | 22.831.627,620… |
| Evening     |      768831 | 23.309.074,930… |
|             |      384272 | 11.904.917,750… |

Usando l'orario medio tra inizio e fine:
Previewing node 'fct_trip__time_revenues':
| time      | n_trips |   total_revenue |
| --------- | ------- | --------------- |
| Morning   |  516724 | 14.565.522,920… |
| Afternoon |  733541 | 22.276.874,760… |
| Evening   |  778417 | 23.944.415,980… |
|           |  399663 | 12.547.952,680… |
*/
