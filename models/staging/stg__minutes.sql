-- esporre minutaggio delle corse

with tripdata as (select * from {{ ref("raw_data")}})

select 
    *,
    extract(EPOCH FROM (tpep_dropoff_datetime - tpep_pickup_datetime)) / 60 AS trip_minutes FROM tripdata
--order by trip_minutes desc