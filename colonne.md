# Dov'è il dataset
qui https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

mappa delle zone di NY https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

### 1. Identificativi e Metadati del Viaggio

| Nome Campo | Spiegazione | Valori Tipici / Note |
| :--- | :--- | :--- |
| **`VendorID`** | Un codice che identifica il fornitore della tecnologia del tassametro. | `1` = Creative Mobile Technologies, LLC<br>`2` = VeriFone Inc. |
| **`RatecodeID`** | Il codice della tariffa finale applicata al viaggio. | `1` = **Standard rate** (tariffa standard)<br>`2` = **JFK** (tariffa fissa per l'aeroporto JFK)<br>`3` = **Newark** (tariffa fissa per l'aeroporto di Newark)<br>`4` = **Nassau or Westchester**<br>`5` = **Negotiated fare** (tariffa negoziata)<br>`6` = **Group ride** (corsa di gruppo) |
| **`store_and_fwd_flag`** | Indica se il dato della corsa è stato memorizzato nel veicolo prima di essere inviato al server. | `Y` = Store and Forward (memorizzato e inviato dopo)<br>`N` = Not a Store and Forward trip (inviato in tempo reale)<br>Questo succede se il terminale non ha connessione di rete al momento della corsa. |
| **`payment_type`** | Il metodo di pagamento utilizzato. | `1` = **Credit card**<br>`2` = **Cash**<br>`3` = No charge (gratuito)<br>`4` = Dispute (contestato)<br>`5` = Unknown (sconosciuto)<br>`6` = Voided trip (viaggio annullato) |

---

### 2. Dettagli Temporali e Geografici

| Nome Campo | Spiegazione | Valori Tipici / Note |
| :--- | :--- | :--- |
| **`tpep_pickup_datetime`** | Data e ora in cui il tassametro è stato attivato (inizio della corsa). | `2025-08-01 00:11:29` (Formato: `YYYY-MM-DD HH:MI:SS`) |
| **`tpep_dropoff_datetime`**| Data e ora in cui il tassametro è stato disattivato (fine della corsa). | `2025-08-01 00:22:26` (Formato: `YYYY-MM-DD HH:MI:SS`) |
| **`PULocationID`** | ID numerico della zona di New York in cui è iniziato il viaggio ("**P**ick**U**p Location ID"). | Un numero da 1 a 265 che corrisponde a una "Taxi Zone" specifica. Per esempio, `249` corrisponde a "Upper West Side South".<br>[Qui la mappa ufficiale delle zone](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page). |
| **`DOLocationID`** | ID numerico della zona di New York in cui è terminato il viaggio ("**D**rop**O**ff Location ID"). | Simile a `PULocationID`, ma per la destinazione. Nel tuo esempio, `231` corrisponde a "TriBeCa/Civic Center". |

---

### 3. Metriche del Viaggio

| Nome Campo | Spiegazione | Valori Tipici / Note |
| :--- | :--- | :--- |
| **`passenger_count`** | Il numero di passeggeri nel veicolo. | `1`, `2`, ecc. A volte può contenere valori anomali come `0`, che potrebbero indicare un errore o una corsa senza passeggeri (es. trasporto pacchi). |
| **`trip_distance`** | La distanza del viaggio registrata dal tassametro, misurata in **miglia**. | `1.81` (cioè 1.81 miglia) |
| **`trip_minutes`** | *(Campo calcolato da te)* La durata totale del viaggio in minuti. | `10.95` (calcolato da `tpep_dropoff_datetime - tpep_pickup_datetime`) |

---

### 4. Dettagli Finanziari

Questi campi rappresentano la scomposizione del costo totale. La loro somma dovrebbe corrispondere a `total_amount`.

| Nome Campo | Spiegazione | Valori Tipici / Note |
| :--- | :--- | :--- |
| **`fare_amount`** | Il costo base della corsa, calcolato in base alla distanza e al tempo. | `12.10` (in dollari $) |
| **`extra`** | Costi extra e supplementi, come il supplemento notturno (dopo le 20:00) o per l'ora di punta (giorni feriali 16:00-20:00). | `1.00` |
| **`mta_tax`** | Tassa obbligatoria di $0.50 imposta dalla MTA (Metropolitan Transportation Authority). | `0.50` |
| **`tip_amount`** | L'importo della mancia. | `3.57`. **Importante**: questo campo è popolato **solo per i pagamenti con carta di credito**. Le mance in contanti non vengono registrate. |
| **`tolls_amount`** | L'importo totale di eventuali pedaggi (ponti, tunnel) pagati durante la corsa. | `0.0` |
| **`improvement_surcharge`** | Un supplemento fisso di $1.00 per "miglioramento". | `1.00` (precedentemente era $0.30) |
| **`congestion_surcharge`** | Supplemento per la congestione applicato ai viaggi che iniziano, terminano o passano per Manhattan a sud della 96a strada. | `2.50` (per taxi gialli) |
| **`Airport_fee`** | Tassa specifica applicata per le corse da/per gli aeroporti (es. LaGuardia, JFK). | `0.0` (in questo caso non applicabile) |
| **`cbd_congestion_fee`** | Una tassa addizionale di congestione per la Central Business District. | `0.75` (spesso può essere inclusa in altri campi a seconda della versione del dataset) |
| **`total_amount`** | **L'importo totale pagato dal cliente.** | `21.42`. Teoricamente dovrebbe essere la somma di tutti i campi finanziari precedenti. |