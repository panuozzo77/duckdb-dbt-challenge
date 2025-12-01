# Valutazione Performance Modelli dbt

In questo documento verranno analizzati i modelli dbt presenti nel progetto, valutando la qualità delle query e potenziali problemi di performance.

## Staging Models (`models/staging/yellow_tripdata`)

### `stg_trip__base.sql`
- **Analisi**: Modello base che importa i dati raw e applica casting dei tipi e generazione di chiavi surrogate.
- **Valutazione**: **Ottimale**.
    - Utilizza `TRY_CAST` per gestire errori di tipo in modo sicuro.
    - Usa `dbt_utils.generate_surrogate_key` che è standard.
    - **Nota**: L'uso di `SELECT *` nella CTE `source` è accettabile per un modello base, ma esplicitare le colonne è sempre preferibile per chiarezza e per evitare di importare colonne inutili se la source dovesse cambiare.

### `stg_trip__cleaned.sql`
- **Analisi**: Applica logica di business per pulire i dati (filtri su pagamenti, passeggeri, durata, distanza, coerenza importi).
- **Valutazione**: **Buona**, ma con attenzione.
    - La logica è complessa e ricca di calcoli row-level (`DATEDIFF`, somme di colonne multiple).
    - Non ci sono JOIN, quindi è scalabile linearmente.
    - **Nota**: La condizione `total_amount >= fare_amount + ...` richiede calcoli per ogni riga. Se il dataset è enorme, questo filtro ha un costo computazionale, ma è necessario per la qualità del dato.

### `stg_trip__speed_filtered.sql`
- **Analisi**: Calcola durata e velocità media per filtrare outlier.
- **Valutazione**: **Ottimale**.
    - Usa CTE per calcolare passaggi intermedi (`trips_with_duration_and_speed`, `trips_with_avg_speed`), rendendo la query leggibile.
    - I calcoli sono semplici operazioni aritmetiche.

**Considerazioni Generali Staging**:
La catena `base` -> `cleaned` -> `speed_filtered` è ben strutturata modularmente. Se questi modelli sono materializzati come `view`, ogni query a valle ricalcolerà tutta la catena, il che potrebbe diventare "pesante" su grandi volumi. Se materializzati come `table` o `incremental`, il costo è pagato solo in fase di build.

## Intermediate Models (`models/intermediate`)

### `int_trip__identifiers.sql`, `int_trip__metrics.sql`, `int_trip__prices.sql`, `int_trip__temporal_spatial.sql`
- **Analisi**: Questi modelli proiettano sottoinsiemi di colonne (vertical slicing) dallo stesso modello upstream (`stg_trip__speed_filtered`).
- **Valutazione**: **Buona** (Organizzativa).
    - Utile per separare domini semantici (prezzi, metriche, tempo/spazio).
    - **Performance**: Sono query leggerissime (solo `SELECT`). Tuttavia, se materializzate come tabelle, duplicano i dati (chiavi primarie ripetute).

### `int_zone__pickup_summary.sql`
- **Analisi**: Esegue una JOIN tra `int_trip__temporal_spatial` e `int_trip__prices` su `trip_id` per aggregare i ricavi per zona di pickup.
- **Valutazione**: **Non Ottimale** (Potenzialmente Pesante).
    - **Problema**: Effettua una JOIN tra due tabelle che derivano dalla *stessa* sorgente (`stg_trip__speed_filtered`). Questo è un pattern inefficiente ("fan-out fan-in").
    - **Ottimizzazione**: Sarebbe molto più performante aggregare direttamente da `stg_trip__speed_filtered` (o da un modello unificato), evitando completamente la JOIN. Il database deve fare un lavoro inutile per ricongiungere righe che erano già unite all'origine.

## Marts Models (`models/marts`)

### `dim_trip__distance_classifier.sql`
- **Analisi**: Classifica i viaggi in 'short', 'medium', 'long' basandosi sulla distanza.
- **Valutazione**: **Ottimale**.
    - Logica row-level semplice (`CASE WHEN`).
    - Molto efficiente.

### `fct_trip__distance_analysis.sql`
- **Analisi**: Unisce classificazione distanze e prezzi per metriche aggregate.
- **Valutazione**: **Accettabile ma migliorabile**.
    - Esegue una JOIN su `trip_id` tra due tabelle che condividono la stessa granularità.
    - Sarebbe più efficiente avere queste informazioni già unite a monte o in un modello "wide".

### `fct_trip__distance_boundaries.sql`
- **Analisi**: Calcola min/max distanza per categoria.
- **Valutazione**: **Ottimale**.
    - Aggregazione semplice su una singola tabella.

### `fct_trip__revenue_by_time_of_day.sql`
- **Analisi**: Calcola ricavi per fascia oraria (Morning, Afternoon, etc.).
- **Valutazione**: **Non Ottimale**.
    - **Join Inutile**: Unisce `int_trip__temporal_spatial` e `int_trip__prices`. Come visto prima, queste due tabelle vengono dalla stessa sorgente. La JOIN è un costo evitabile.
    - **Calcoli Ripetuti**: Il calcolo dell'orario medio viene ripetuto più volte nel `CASE`. Meglio calcolarlo una volta in una CTE o usare una macro.

### `fct_vendor__tip_percentage.sql`
- **Analisi**: Calcola percentuale mance per vendor.
- **Valutazione**: **Ottimale**.
    - Aggregazione semplice.

### `fct_zone__top5_by_revenue.sql` e `fct_zone__top5_by_trips.sql`
- **Analisi**: Classifiche top 5 zone.
- **Valutazione**: **Dipendente**.
    - Le query in sé sono banali (`ORDER BY` + `LIMIT`).
    - Tuttavia, dipendono da `int_zone__pickup_summary` che è stato valutato come **Non Ottimale** a causa della JOIN. Se il modello upstream è lento, questi saranno lenti.

## Conclusioni Generali
Il progetto è ben strutturato semanticamente (nomi chiari, separazione di concetti). Tuttavia, l'eccessiva frammentazione "verticale" nei modelli `intermediate` (separare prezzi, metriche, tempo in tabelle diverse) porta a dover fare molte JOIN sui modelli `marts` per rimettere insieme i pezzi.
**Consiglio**: Valutare la creazione di un modello `intermediate` "wide" che contenga tutte le colonne pulite, da cui i mart possono attingere senza dover fare JOIN su `trip_id`.

