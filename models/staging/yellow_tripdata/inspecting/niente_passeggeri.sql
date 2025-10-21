--file preso dai target compilati
select
    pickup,
    dropoff,
    start_location_id,
    end_location_id,
    total_amount,
    trip_distance
from "yellow_tripdata"."main"."stg_2_trip__cleaned"

where not(passenger_count > 0)

-- sembra comunque che sebbene non ci siano passeggeri, gli altri dati risultano essere presenti