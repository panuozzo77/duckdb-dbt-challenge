{{ config(
    tags=['inspecting']
)}}



select
    *
from "yellow_tripdata"."main"."stg_trip__cleaned"

where not(total_amount >= fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee)

