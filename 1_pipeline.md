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
