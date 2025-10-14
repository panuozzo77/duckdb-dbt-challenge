Fase 1: Le Basi Fondamentali (Cosa sono DBT e DuckDB?)
Prima di scrivere codice, è essenziale capire il ruolo di questi due strumenti.

DBT (Data Build Tool):

Cos'è: Non è uno strumento per estrarre o caricare dati (non è un ETL), ma si concentra sulla T (Trasformazione). Pensa a DBT come a un framework per scrivere, organizzare e eseguire query SQL in modo robusto, ripetibile e testabile.
Perché si usa: Permette di applicare i principi dello sviluppo software (come version control, test e modularità) all'analisi dei dati.
Keyword da cercare:
"What is dbt?"
"Analytics Engineering"
"dbt core vs dbt cloud"
"ELT vs ETL paradigm"
Risorse Utili:
Corso Gratuito Ufficiale di DBT (il "dbt Fundamentals" è un ottimo punto di partenza).
Documentazione Ufficiale di DBT

DuckDB:

Cos'è: È un database analitico "in-process". A differenza di database come PostgreSQL o MySQL che richiedono un server, DuckDB gira direttamente all'interno della tua applicazione (in questo caso, DBT). È incredibilmente veloce per le query analitiche (OLAP).
Perché si usa qui: È perfetto per lo sviluppo locale e per analizzare file come Parquet o CSV senza doverli importare in un database pesante.
Keyword da cercare:
"What is DuckDB?"
"In-process OLAP database"
"DuckDB vs SQLite"
"DuckDB read parquet directly"
Risorse Utili:
Documentazione Ufficiale di DuckDB
Video introduttivi su YouTube
