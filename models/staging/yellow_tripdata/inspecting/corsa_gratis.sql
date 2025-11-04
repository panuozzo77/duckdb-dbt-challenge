{{ config(
    tags=['inspecting']
)}}

--file preso dai target compilati
select
    pickup,
    dropoff,
    start_location_id,
    end_location_id,
    total_amount,
--    trip_distance,
    passenger_count,
from "yellow_tripdata"."main"."stg_trip__speed_filtered"

where total_amount < 0

-- sono presenti valori sono in negativo 