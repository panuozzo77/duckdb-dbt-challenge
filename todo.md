# cosa_studiare

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
Fase 2: Costruire la Pipeline con DBT
Una volta comprese le basi, concentrati sulla struttura e i concetti di un progetto DBT.

Struttura di un Progetto DBT:

Models: Sono dei semplici file .sql che contengono una singola SELECT. DBT si occupa di materializzare il risultato di questa select in tabelle o viste nel database.
Staging Models: Il primo strato di trasformazione. Il loro scopo è pulire i dati grezzi: rinominare colonne, fare casting dei tipi, gestire valori nulli. Non dovrebbero contenere logica di business complessa o join.
Data Marts (o Marts Models): L'ultimo strato. Qui si aggregano i dati puliti dagli staging models per creare tabelle utili per analisi o business intelligence. Contengono logica di business, join e aggregazioni.
Keyword da cercare:
"dbt project structure"
"dbt staging models best practices"
"dbt mart models"
"dbt model materialization" (impara la differenza tra table, view, incremental).
Funzionalità Chiave di DBT per questa Challenge:

Sources: Come definire le tue fonti di dati grezzi (il file Parquet) in DBT usando un file sources.yml. Questo ti permette di selezionare i dati grezzi con la funzione {{ source('nome_sorgente', 'nome_tabella') }}.
Macros e Jinja: DBT usa il templating engine Jinja (molto usato anche in Python con Flask/Django). Ti permette di scrivere codice che scrive SQL, evitando ripetizioni (principio DRY - Don't Repeat Yourself). Ad esempio, potresti creare una macro per classificare le corse in "corte", "medie" e "lunghe".
Tests: DBT ha un framework di testing integrato.
Schema Tests: Test generici e predefiniti come unique, not_null, accepted_values. Si definiscono in file .yml.
Data Tests: Test custom che puoi scrivere come query SQL. La query deve ritornare zero righe per passare il test.
Keyword da cercare:
"dbt sources"
"dbt jinja tutorial"
"dbt macros examples"
"dbt schema and data tests"
Fase 3: SQL per l'Analisi dei Dati
DBT orchestra le query, ma il cuore del lavoro rimane SQL. Ecco le funzioni e i concetti SQL che ti serviranno, specifici per il dialetto di DuckDB.

Manipolazione di Date e Orari:

Per calcolare la durata della corsa e raggruppare per fasce orarie.
Keyword e Funzioni da Cercaere (per DuckDB):
"duckdb date functions"
"duckdb date_diff" o timestamp - timestamp
EXTRACT(HOUR FROM timestamp) o strftime(timestamp, '%H')
CASE WHEN (fondamentale per creare le fasce orarie e altre classificazioni).
Aggregazioni e Window Functions:

Per calcolare le metriche richieste nei data marts (totali, medie, top 5).
Keyword e Funzioni da Cercaere:
GROUP BY, SUM, AVG, COUNT
"sql window functions"
ROW_NUMBER() o RANK() (essenziali per identificare i "Top 5 Pickup Zones").
Pulizia e Trasformazione:

Per gestire i dati sporchi come richiesto.
Keyword e Funzioni da Cercaere:
WHERE clause per filtrare i valori implausibili.
CAST(column AS a_new_type) per cambiare i tipi di dato.
COALESCE(column, default_value) per gestire i NULL.

Percorso di Apprendimento Suggerito
Giorno 1-2: Completa il corso "dbt Fundamentals". Installa DBT e DuckDB in locale e prova a eseguire un progetto di esempio.
Giorno 3: Concentrati su SQL. Fai pratica con le funzioni di data/ora e le window functions usando DuckDB sulla riga di comando direttamente sul file Parquet.
Giorno 4-5: Inizia a costruire i tuoi staging models. Definisci le sources, pulisci le colonne e applica le prime trasformazioni semplici.
Giorno 6: Impara e implementa i test di base (unique, not_null) sui tuoi staging models per assicurarti della qualità dei dati.
Giorno 7-8: Costruisci i data marts. Scrivi le query con GROUP BY e window functions per rispondere alle domande di business.
Giorno 9: Refactoring. Identifica la logica ripetuta e trasformala in macros per rendere il tuo progetto più pulito e manutenibile.
Giorno 10: Documentazione. Scrivi il README.md come richiesto.