# Le fonti

qui https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

in particolare, è stato scaricato il dataset delle corse di Agosto 2025

il dizionario dei dati (info sulle colonne) è [questo](/docs/data_dictionary_trip_records_yellow.pdf)

È risultato utile per la creazione della documentazione.

**NOTA:** la documentazione con lo stack tecnologico impiegato (DuckDB + dbt) non permette la propagazione, costringendo a doverla riscrivere/allegare per ciascun modello la documentazione. È possibile evitarlo con altri tool di Data Warehouse

---

# Caricamento dataset nel db

è stato caricato tutto il file parquet in DuckDB col nome di tabella 'raw_data'

```bash
uv run duckdb data/db/yellow_tripdata.duckdb -c "CREATE OR REPLACE TABLE raw_data AS SELECT * FROM read_parquet('yellow_tripdata_2025-08.parquet');"
```

---

# Modelli di staging

per passare ai [modelli di staging qui](/narration/1_staging/1.md)