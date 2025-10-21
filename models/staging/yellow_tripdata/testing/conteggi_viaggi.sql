-- Test: corse con tragitti 'strani'
SELECT
    COUNT_IF(start_location_id = end_location_id) AS stesso_id,
    COUNT_IF(start_location_id = end_location_id AND total_amount = 0) AS "$=0",
    COUNT_IF(start_location_id != end_location_id AND trip_distance = 0) AS err_dist,
    COUNT_IF(start_location_id != end_location_id AND trip_distance < 0) AS neg_dist,
    --COUNT_IF(total_amount = 0 AND passenger_count = 0) AS corse_nulle
FROM {{ ref('stg_2_trip__cleaned') }}

/*
Previewing node 'conteggi_viaggi':
| stesso_id | $=0 | err_dist | neg_dist |
| --------- | --- | -------- | -------- |
|    159314 | 253 |    69844 |        0 |

Esiste un set di corse che, seppure con location differenti di inizio e fine hanno distanza pari a 0
*/