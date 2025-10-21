-- payment_type IN (0, 1, 2, 3, 4, 5, 6)
SELECT
    COUNT_IF(total_amount <= 0 AND payment_type = 0) AS flessibile,
    COUNT_IF(total_amount <= 0 AND payment_type = 1) AS carta,
    COUNT_IF(total_amount <= 0 AND payment_type = 2) AS cash, -- per il readme è PREPAID
    COUNT_IF(total_amount <= 0 AND payment_type = 3) AS ggratis,
    COUNT_IF(total_amount <= 0 AND payment_type = 4) AS problema,
    COUNT_IF(total_amount <= 0 AND payment_type = 5) AS sconosciuto,
    COUNT_IF(total_amount <= 0 AND payment_type = 6) AS cancellato,

FROM {{ ref('stg_2_trip__cleaned') }}
/*
Pagamenti > 0

Previewing node 'tipi_pagamenti':
| flessibile |   carta |   cash | ggratis | problema | sconosciuto | cancellato |
| ---------- | ------- | ------ | ------- | -------- | ----------- | ---- 
|     875797 | 2182684 | 352846 |   18035 |    56271 |           0 |    0 

Pagamenti <= 0
Previewing node 'tipi_pagamenti':
| flessibile | carta |  cash | ggratis | problema | sconosciuto | cancellato |
| ---------- | ----- | ----- | ------- | -------- | ----------- | ---- 
|      10437 |    54 | 17831 |    9766 |    50370 |           0 |    0

14:18:16  Finished running 8 data tests in 0 hours 0 minutes and 0.30 seconds (0.30s).
14:18:16  
14:18:16  Completed with 3 errors, 0 partial successes, and 0 warnings:
14:18:16  
14:18:16!!!  Failure in test dbt_utils_expression_is_true_stg_2_trip__cleaned_DATEDIFF_minute_pickup_dropoff_BETWEEN_1_AND_24_60_ (models/staging/yellow_tripdata/_stg_yellow_tripdata.yml)
14:18:16    Got 82300 results, configured to fail if != 0
14:18:16  
14:18:16    compiled code at target/compiled/challenge/models/staging/yellow_tripdata/_stg_yellow_tripdata.yml/dbt_utils_expression_is_true_s_e6b615cd2804dc1a8fa9baa64564d291.sql
14:18:16  
14:18:16!!!  Failure in test dbt_utils_expression_is_true_stg_2_trip__cleaned_passenger_count___0 (models/staging/yellow_tripdata/_stg_yellow_tripdata.yml)
14:18:16    Got 17272 results, configured to fail if != 0
14:18:16  
14:18:16    compiled code at target/compiled/challenge/models/staging/yellow_tripdata/_stg_yellow_tripdata.yml/dbt_utils_expression_is_true_s_0c883e198b142feec193ba26712432a3.sql
14:18:16  
14:18:16!!!  Failure in test dbt_utils_expression_is_true_stg_2_trip__cleaned_total_amount___0 (models/staging/yellow_tripdata/_stg_yellow_tripdata.yml)
14:18:16    Got 88458 results, configured to fail if != 0
14:18:16  
14:18:16    compiled code at target/compiled/challenge/models/staging/yellow_tripdata/_stg_yellow_tripdata.yml/dbt_utils_expression_is_true_s_8895ad25f5a4854aabe58e8f64381f88.sql
14:18:16  
14:18:16  Done. PASS=5 WARN=0 ERROR=3 SKIP=0 NO-OP=0 TOTAL=8
*/