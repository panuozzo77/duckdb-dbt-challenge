{{ config(
    tags=['inspecting']
)}}

SELECT
    SUM(CASE WHEN NOT(DATEDIFF('minute', pickup, dropoff) BETWEEN 1 AND (24*60)) AND total_amount = 0 THEN 1 ELSE 0 END) as istantanei_e_gratis,
    SUM(CASE WHEN NOT(DATEDIFF('minute', pickup, dropoff) BETWEEN 1 AND (24*60)) AND total_amount != 0 THEN 1 ELSE 0 END) as istantanei_e_non_gratis,
    SUM(CASE WHEN NOT(DATEDIFF('minute', pickup, dropoff) BETWEEN 1 AND (24*60)) AND total_amount < 0 THEN 1 ELSE 0 END) as istantanei_e_negativi
FROM {{ ref('stg_trip__speed_filtered') }}

/*
Previewing node 'corsa_istantanea':
| istantanei_e_gratis | istantanei_e_non_... | istantanei_e_nega... |
| ------------------- | -------------------- | -------------------- |
|                 160 |                82140 |                 5037 |

con stg_3_trip__speed_cleaned
Previewing node 'corsa_istantanea':
| istantanei_e_gratis | istantanei_e_non_... | istantanei_e_nega... |
| ------------------- | -------------------- | -------------------- |
|                   0 |                    0 |                    0 |
*/