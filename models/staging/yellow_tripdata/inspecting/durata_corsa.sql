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
    trip_distance,
from "yellow_tripdata"."main"."stg_trip__speed_filtered"

where not(DATEDIFF('minute', pickup, dropoff) BETWEEN 1 AND (24*60)) AND total_amount = 0

/*

- motivi per cui la corsa può essere 0 e costare 0:
    - inizio e fine coincidono
    - per qualche ragione (non ci interessa perché) non è stata trasmessa la fine della corsa
    - per qualche ragione non è stato registrato il costo della corsa

-- vanno eliminati almeno gli spostamenti dove: start_location = end_location ed il loro totale è 0 


    vendorid AS vendor_id,
    tpep_pickup_datetime as pickup,
    tpep_dropoff_datetime as dropoff,
    ratecodeid AS rate_code_id,
    store_and_fwd_flag,
    pulocationid AS start_location_id,
    dolocationid AS end_location_id,
    passenger_count,
    trip_distance,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    congestion_surcharge,
    airport_fee,
    payment_type,
    total_amount

*/