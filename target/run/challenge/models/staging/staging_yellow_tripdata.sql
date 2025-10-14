
  
    
    

    create  table
      "yellow_tripdata"."main"."staging_yellow_tripdata__dbt_tmp"
  
    as (
      

SELECT * FROM 'data/raw/yellow_tripdata_2025-08.parquet'
    );
  
  