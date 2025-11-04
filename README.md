<img src="https://assets.website-files.com/61a888508b7cccb7485cdac2/61b31d9009792071f950394b_logo_dscovr.svg">


# Data Engineer: DuckDB & DBT - Dynamic Data Modeling Challenge

Please follow the commands in the order as shown for the best experience!

### Repo quick start

```shell
$ uv venv

$ source .venv/bin/activate

$ uv sync

$ wget https://github.com/duckdb/duckdb/releases/download/v1.4.0/duckdb_cli-linux-amd64.zip && unzip duckdb_cli-linux-amd64.zip && mv duckdb .venv/bin/

$ uv run dbt deps 

$ wget  https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2025-08.parquet -P data/raw

$ uv run dbt run

[wait until you see...]
13:38:14  
13:38:14  Completed successfully
13:38:14  

# execute this and see if it output 10 lines
$ uv run duckdb data/db/yellow_tripdata.duckdb "select  * from staging_yellow_tripdata limit 10"
---

### Documentation

```shell
$ uv run dbt docs generate

$ uv run dbt docs serve
```

Si aprirà il tuo browser predefinito con una pagina con cui puoi navigare per i modelli e leggere le informazioni sulle varie colonne del dataset.

---

### Testing

```shell
$ uv run dbt test

15:00:04  
15:00:04  Finished running 55 data tests in 0 hours 0 minutes and 3.20 seconds (3.20s).
15:00:04  
15:00:04  Completed successfully
15:00:04  
15:00:04  Done. PASS=55 WARN=0 ERROR=0 SKIP=0 NO-OP=0 TOTAL=55
```

### Visualizing the marts

Per una visione migliore del risultato sul terminale, consiglio di utilizzare il comando via CLI di duckdb, solo dopo aver eseguito ```dbt run``` per la generazione delle tabelle nel db.

#### A. **Trips by Time of Day**

```shell
$ uv run duckdb data/db/yellow_tripdata.duckdb "select * from fct_trip__revenue_by_time_of_day"

$ uv run dbt show -s fct_trip__revenue_by_time_of_day

```

#### B. **Top 5 Pickup Zones**

```shell
$ uv run duckdb data/db/yellow_tripdata.duckdb "select * from int_zone__pickup_summary ORDER BY num_trips DESC LIMIT 5"

$ uv run duckdb data/db/yellow_tripdata.duckdb "select * from int_zone__pickup_summary ORDER BY total_revenue DESC LIMIT 5"

# altrimenti con dbt

$ uv run dbt show -s fct_zone__top5_by_revenue

$ uv run dbt show -s fct_zone__top5_by_trips

```

#### C. **Driver/Rate Performance**

```shell
$ uv run duckdb data/db/yellow_tripdata.duckdb "select * from fct_vendor__tip_percentage"

# altrimenti con dbt

$ uv run dbt show -s fct_vendor__tip_percentage

```

#### D. **Distance Analysis**

```shell
$ uv run duckdb data/db/yellow_tripdata.duckdb "select * from fct_trip__distance_analysis"

# altrimenti con dbt

$ uv run dbt show -s fct_trip__distance_analysis

```

## Contacts

For questions or clarifications about the challenge: [https://linktr.ee/mauro.malvestio](https://linktr.ee/mauro.malvestio)

For questions about the solution: write an issue on github!