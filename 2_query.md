Fase 3: SQL per l'Analisi dei Dati
DBT orchestra le query, ma il cuore del lavoro rimane SQL. Ecco le funzioni e i concetti SQL che ti serviranno, specifici per il dialetto di DuckDB.

Manipolazione di Date e Orari:

Per calcolare la durata della corsa e raggruppare per fasce orarie.
Keyword e Funzioni da Cercare (per DuckDB):
"duckdb date functions"
"duckdb date_diff" o timestamp - timestamp
EXTRACT(HOUR FROM timestamp) o strftime(timestamp, '%H')
CASE WHEN (fondamentale per creare le fasce orarie e altre classificazioni).
Aggregazioni e Window Functions:

Per calcolare le metriche richieste nei data marts (totali, medie, top 5).
Keyword e Funzioni da Cercare:
GROUP BY, SUM, AVG, COUNT
"sql window functions"
ROW_NUMBER() o RANK() (essenziali per identificare i "Top 5 Pickup Zones").
Pulizia e Trasformazione:

Per gestire i dati sporchi come richiesto.
Keyword e Funzioni da Cercare:
WHERE clause per filtrare i valori implausibili.
CAST(column AS a_new_type) per cambiare i tipi di dato.
COALESCE(column, default_value) per gestire i NULL.
Percorso di Apprendimento Suggerito