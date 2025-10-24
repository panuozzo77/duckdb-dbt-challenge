-- Test: corse con tragitti 'strani'
SELECT
    COUNT_IF(start_location_id = end_location_id) AS stesso_id,
    COUNT_IF(start_location_id = end_location_id AND total_amount = 0) AS "$=0",
    COUNT_IF(start_location_id != end_location_id AND trip_distance > 0) AS correct,
    COUNT_IF(start_location_id != end_location_id AND trip_distance = 0) AS err_dist,
    COUNT_IF(start_location_id != end_location_id AND trip_distance < 0) AS neg_dist,
    --COUNT_IF(total_amount = 0 AND passenger_count = 0) AS corse_nulle
FROM {{ ref('stg_trip__speed_filtered') }}

/*
Previewing node 'conteggi_viaggi':
| stesso_id | $=0 | err_dist | neg_dist |
| --------- | --- | -------- | -------- |
|    159314 | 253 |    69844 |        0 |

< 3.5h
Previewing node 'conteggi_viaggi':
| stesso_id | $=0 | correct | err_dist | neg_dist |
| --------- | --- | ------- | -------- | -------- |
|     94528 |  33 | 2409672 |        0 |        0 |

< 5h
Previewing node 'conteggi_viaggi':
| stesso_id | $=0 | correct | err_dist | neg_dist |
| --------- | --- | ------- | -------- | -------- |
|     94553 |  33 | 2409765 |        0 |        0 |

qualsiasi ora
Previewing node 'conteggi_viaggi':
| stesso_id | $=0 | correct | err_dist | neg_dist |
| --------- | --- | ------- | -------- | -------- |
|    101599 |  41 | 2456581 |        0 |        0 |
Esiste un set di corse che, seppure con location differenti di inizio e fine hanno distanza pari a 0
*/