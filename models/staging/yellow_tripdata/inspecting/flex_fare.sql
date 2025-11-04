{{ config(
    tags=['inspecting']
)}}

WITH source_data AS (
    SELECT
        payment_type,
        trip_distance
    FROM {{ ref('stg_trip__cleaned') }}
)

SELECT
    CASE
        WHEN payment_type = 0 THEN '0 - Flex'
        WHEN payment_type = 1 THEN '1 - Card'
        WHEN payment_type = 2 THEN '2 - Cash'
        WHEN payment_type = 3 THEN '3 - No Charge'
        WHEN payment_type = 4 THEN '4 - Dispute'
        WHEN payment_type = 5 THEN '5 - Unknown'
        WHEN payment_type = 6 THEN '6 - Voided'
        ELSE 'Altro'
    END AS tipo_pagamento,

    COUNT_IF(trip_distance <= 0) AS corse_a_distanza_zero,

    COUNT_IF(trip_distance > 0) AS corse_con_distanza_positiva,

    COUNT(*) AS totale_corse,

    ROUND(
        100.0 * corse_a_distanza_zero / NULLIF(totale_corse, 0),
        2
    ) AS percentuale_distanza_zero

FROM source_data
GROUP BY
    tipo_pagamento
ORDER BY
    percentuale_distanza_zero DESC,
    totale_corse DESC

/*

Pre-Cleaning

Previewing node 'inspect_flex_fare':
| tipo_pagamento  | corse_a_distanza_... | corse_con_distanz... | totale_corse | percentuale_dista... |
| --------------- | -------------------- | -------------------- | ------------ | -------------------- |
| 3 - No Charge   |                 5027 |                22774 |        27801 |                18,08 |
| 0 - Flex Fare   |                64825 |               821409 |       886234 |                 7,31 |
| 4 - Dispute     |                 6516 |               100125 |       106641 |                 6,11 |
| 2 - Cash        |                 8431 |               362246 |       370677 |                 2,27 |
| 1 - Credit Card |                20385 |              2162353 |      2182738 |                 0,93 |

Post-Cleaning:

Previewing node 'inspect_flex_fare':
| tipo_pagamento | corse_a_distanza_... | corse_con_distanz... | totale_corse | percentuale_dista... |
| -------------- | -------------------- | -------------------- | ------------ | -------------------- |
| 1 - Card       |                    0 |              2106157 |      2106157 |                    0 |
| 2 - Cash       |                    0 |               334459 |       334459 |                    0 |
| 4 - Dispute    |                    0 |                51203 |        51203 |                    0 |
| 3 - No Charge  |                    0 |                13478 |        13478 |                    0 |
*/