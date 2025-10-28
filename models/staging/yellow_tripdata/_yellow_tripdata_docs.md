{% docs trip_id %}
Chiave generata per identificare ogni singola corsa. Creato combinando tutti i campi delle colonne per garantire l'univocità.
{% enddocs %}

{% docs vendor_id %}
Ditte dei taxi. I valori comuni includono:
1 = Creative Mobile Technologies, LLC
2 = Curb Mobility, LLC
6 = Myle Technologies Inc
7 = Helix
{% enddocs %}

{% docs rate_code_id %}
Codice tariffario applicato alla corsa. Definisce come viene calcolato il costo del viaggio. I valori standard includono:
1 = Tariffa standard
2 = JFK
3 = Newark
4 = Nassau o Westchester
5 = Tariffa negoziata
6 = Corsa di gruppo
{% enddocs %}

{% docs payment_type %}
Metodo utilizzato per pagare la corsa. I valori includono:
1 = Carta di credito
2 = Contanti (o prepaid)
3 = Nessun addebito
4 = Disputa
5 = Sconosciuto
6 = Corsa annullata
{% enddocs %}

{% docs store_and_fwd_flag %}
Flag che indica se i dati della corsa sono stati memorizzati o inviati al server subito.
Y = Sì, memorizzato e inoltrato
N = No, inviato in tempo reale
{% enddocs %}

{% docs location_id %}
ID numerico che rappresenta una specifica zona geografica (TLC Taxi Zone) a New York City. Utilizzato per [start_location_id] e [end_location_id].
{% enddocs %}

{% docs total_amount %}
L'importo totale addebitato al passeggero includendo tasse, supplementi, mance e pedaggi.
{% enddocs %}