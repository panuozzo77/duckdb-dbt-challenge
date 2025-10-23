-- Test: Conta corse con costo 0 e costo < 0
SELECT
    COUNT_IF(total_amount > 0) AS corse_costo_positivo,
    COUNT_IF(total_amount = 0) AS corse_costo_zero,
    COUNT_IF(total_amount < 0) AS corse_costo_negativo,
    COUNT_IF(total_amount = 0 AND passenger_count = 0) AS corse_nulle,
    COUNT_IF(passenger_count = 0) AS no_passeggeri
FROM {{ ref('stg_3_trip__speed_cleaned') }}

/*
Previewing node 'conteggi_costi':
| corse_costo_positivo | corse_costo_zero | corse_costo_negativo | corse_nulle | no_passeggeri |
| -------------------- | ---------------- | -------------------- | ----------- | ------------- |
|              3485633 |              518 |                87940 |          12 |         17272 |

su stg_3_trip__speed_cleaned
Previewing node 'conteggi_costi':
| corse_costo_positivo | corse_costo_zero | corse_costo_negativo | corse_nulle | no_passeggeri |
| -------------------- | ---------------- | -------------------- | ----------- | ------------- |
|              2382791 |               69 |                    0 |           0 |             0 |

La stragrande maggioranza delle corse ha valori in negativo, o sono considerate perdite o sono degli errori
*/