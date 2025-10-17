#### A. **Trips by Time of Day** [Mandatory]
- Calculate the total number of trips and total revenue (`total_amount`) for different time slots:
  - Morning (5:00-12:00)
  - Afternoon (12:00-17:00)
  - Evening (17:00-22:00)
  - Night (22:00-5:00)


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

