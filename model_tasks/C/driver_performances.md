#### C. **Driver/Rate Performance** [Mandatory]
- Analyze **tips**:
  - Calculate the average tip percentage (`tip_amount / total_amount`) for each `VendorID`.

TODO: indagare perché gli altri vendor sono stati cancellati con le pulizie precedenti

  Previewing node 'fct_vendor_tip_percentage':
| vendor_id | tip_percentage |
| --------- | -------------- |
|         1 |         0,110… |
|         2 |         0,127… |

Gli altri vendor (6, 7) sono stati totalmente eliminati perché possiedono valori non validi
- per VendorID7 [47276 corse], vengono tutti eliminati perché non utilizzano una durata consona
- VendorID6 [2580 corse], vengono tutti eliminati perché hanno un numero di passeggeri uguale a null

uv run duckdb data/db/yellow_tripdata.duckdb "select * from vendor_esclusi_null"
┌───────────┬───────────────────┬───────────────────┬──────────────────────┬─────────────┬──────────────┬────────────────────┬──────────────────┬─────────────────┐
│ vendor_id │ null_payment_type │ null_total_amount │ null_passenger_count │ null_pickup │ null_dropoff │ null_trip_distance │ null_fare_amount │ total_raw_trips │
│   int32   │      int128       │      int128       │        int128        │   int128    │    int128    │       int128       │      int128      │      int64      │
├───────────┼───────────────────┼───────────────────┼──────────────────────┼─────────────┼──────────────┼────────────────────┼──────────────────┼─────────────────┤
│         1 │                 0 │                 0 │                95045 │           0 │            0 │                  0 │                0 │          656568 │
│         2 │                 0 │                 0 │               788609 │           0 │            0 │                  0 │                0 │         2867667 │
│         6 │                 0 │                 0 │                 2580 │           0 │            0 │                  0 │                0 │            2580 │
│         7 │                 0 │                 0 │                    0 │           0 │            0 │                  0 │                0 │           47276 │
└───────────┴───────────────────┴───────────────────┴──────────────────────┴─────────────┴──────────────┴────────────────────┴──────────────────┴─────────────────┘

uv run duckdb data/db/yellow_tripdata.duckdb "select * from vendor_esclusi"
┌──────────┬───────────────────────────┬───────────────────────────────┬──────────────────────────────┬───────────────────────┬───────────────────────┬─────────────────────────────────┬─────────────────┐
│ VendorID │ failed_payment_type_check │ failed_amount_coherence_check │ failed_passenger_count_check │ failed_duration_check │ failed_distance_check │ failed_total_amount_logic_check │ total_raw_trips │
│  int32   │          int128           │            int128             │            int128            │        int128         │        int128         │             int128              │      int64      │
├──────────┼───────────────────────────┼───────────────────────────────┼──────────────────────────────┼───────────────────────┼───────────────────────┼─────────────────────────────────┼─────────────────┤
│        1 │                      6051 │                        470378 │                        16476 │                  8631 │                 11091 │                             301 │          656568 │
│        2 │                    100239 │                         51503 │                          796 │                 40263 │                 92953 │                           87940 │         2867667 │
│        6 │                         0 │                             0 │                            0 │                     9 │                     0 │                              26 │            2580 │
│        7 │                       351 │                             0 │                            0 │                 47276 │                  1140 │                               0 │           47276 │
└──────────┴───────────────────────────┴───────────────────────────────┴──────────────────────────────┴───────────────────────┴───────────────────────┴─────────────────────────────────┴─────────────────┘