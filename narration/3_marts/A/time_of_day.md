#### A. **Trips by Time of Day** [Mandatory]
- Calculate the total number of trips and total revenue (`total_amount`) for different time slots:
  - Morning (5:00-12:00)
  - Afternoon (12:00-17:00)
  - Evening (17:00-22:00)
  - Night (22:00-5:00)

Non ci sono requisiti in merito alla richiesta, abbiamo carta bianca su come calcolarlo.
es: 
- per il tassametro è sicuramente importante l'orario di inizio della corsa
- per conoscere invece gli orari di punta servirebbe una heatmat delle 24h per trovare picchi e cali. Magari una heatmap per ciascun giorno della settimana


# Problema: gestire caso in cui una corsa inizi a metà tra queste fasce orarie.

- Per me si 'allega' alla fascia oraria dove si è trascorso più tempo.
Es: corsa dalle 11:50 alle 12:30 > Afternoon. Non  va contata come doppia corsa.
PRO: effettivamente mappiamo dove è presente il maggior carico durante le fasce orarie
CONS: però lavorare facendo calcoli percentuali e capire in che casistiche si finisce mi sa che porta al delirio con SQL.

- lazy: si usa solo l'orario di inizio corsa. 
PRO: è semplicissimo 
CONS: molto approssimativo e probabilmente non sufficiente per indagini di flusso

- alternativa: fare la media tra tempo iniziale e finale ed in base all'orario ottenuto si inserisce nella fascia corretta.
CONS: 


Non conoscendo lo scopo finale dell'analisi ma:
- supponendo sia un'analisi grossolana
- supponendo che le corse dei taxi non sforino le 5-6h e quindi NON accada mai che le corse occupino più di 2 fasce orarie, 

--> la media start/finish dovrebbe essere sufficiente per comprendere dove si concentrino maggiormente i flussi.

---

UPDATE: sapendo che le corse 'pulite' durano in media sotto le 3.5h, calcolando l'orario centrale tra l'inizio e la fine della corsa abbiamo una miglior identificazione di quando sono avvenute le tratte, specie per le tratte che durano molto poco ma che sono al limite tra 2 slot temporali.

```sql
WITH
time_zones AS (
    SELECT
        trip_id,
        pickup,
        dropoff,
        CASE
            WHEN EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) >= 5 AND EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) >= 12 AND EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) < 17 THEN 'Afternoon'
            WHEN EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) >= 17 AND EXTRACT(HOUR FROM (pickup + (dropoff - pickup)/2)) < 22 THEN 'Evening'
            ELSE 'Night'
        END AS time_of_day
    FROM {{ ref('int_trip__temporal_spatial') }}
),

revenues AS (
    SELECT
        trip_id,
        total_amount
    FROM {{ ref('int_trip__prices') }}
),

joined AS (
    SELECT 
        time_zones.time_of_day,
        revenues.total_amount
    FROM time_zones
    JOIN revenues ON time_zones.trip_id = revenues.trip_id
)

SELECT
    time_of_day as 'time',
    COUNT(*) AS n_trips,
    TRY_CAST(SUM(total_amount) AS DECIMAL(10, 2)) AS total_revenue
FROM joined
GROUP BY time_of_day
ORDER BY
    CASE time_of_day
        WHEN 'Morning' THEN 1
        WHEN 'Afternoon' THEN 2
        WHEN 'Evening' THEN 3
        WHEN 'Night' THEN 4
    END
```