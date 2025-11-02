/* pulizia dei dati
WITH source AS (
    SELECT *
    FROM {{ ref('stg_trip__base') }}
)
SELECT *
FROM source
--
--WHERE
--    trip_distance >= 0
--    AND total_amount > 0
--    -- un viaggio deve avere almeno un passeggero
--    AND passenger_count > 0
--    AND DATEDIFF('minute', pickup, dropoff) BETWEEN 1 AND 24 * 60
--
--    -- campi che hanno un elenco di valori ammissibili, come da PDF
--    AND vendor_id IN (1, 2, 6, 7)
--    AND rate_code_id IN (1, 2, 3, 4, 5, 6, 99)
--    AND store_and_fwd_flag IN ('Y', 'N')
--    AND payment_type IN (0, 1, 2, 3, 4, 5, 6)
--
*/

-- pulizia dei dati con logica avanzata
WITH source AS (
    SELECT *
    FROM {{ ref('stg_trip__base') }}
)

SELECT *
FROM source
WHERE
    -- Regola 1: Filtra i tipi di pagamento che non rappresentano una transazione valida
    payment_type NOT IN (4, 5, 6)

    -- Regola 2: L'importo totale deve essere coerente con il tipo di pagamento.
    -- Deve essere > 0 per pagamenti reali (Carta, Contanti) o può essere 0 per 'No Charge' e 'Dispute'.
    AND (
        total_amount > 0 OR
        (total_amount = 0 AND payment_type IN (2, 3))
    )

    -- Regola 3: Un viaggio deve avere almeno un passeggero.
    AND passenger_count > 0

    -- Regola 4: La durata del viaggio deve essere plausibile (tra 1 minuto e 3.5 ore).
    -- Questo esclude anche i casi in cui dropoff <= pickup.
    AND DATEDIFF('minute', pickup, dropoff) BETWEEN 1 AND (3.5 * 60)

    -- Regola 5: Un viaggio deve avere una distanza percorsa > 0 per essere significativo.
    -- Questo elimina i "non-viaggi" e gli errori di dati con distanza zero.
    AND trip_distance > 0

    -- Regola 6: Coerenza logica tra l'importo totale e la tariffa base.
    -- Il totale deve essere almeno pari alla tariffa base.
    AND total_amount >= fare_amount + extra + mta_tax + tip_amount + tolls_amount + improvement_surcharge + congestion_surcharge + airport_fee

    -- Regola 7: Distanze umanamente fattibili a 120km/h in 3.5h
    AND trip_distance <= 420