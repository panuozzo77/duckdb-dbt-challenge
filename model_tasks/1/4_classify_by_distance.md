La classificazione delle corse per distanza è avvenuta dividendo in terzili in base alla distanza sempre crescente.

Problema:

Previewing node 'boundaries':
| distance_category | min_distance | max_distance | number_of_trips |
| ----------------- | ------------ | ------------ | --------------- |
| short             |         0,01 |         1,30 |          809449 |
| medium            |         1,30 |         2,80 |          809448 |
| long              |         2,80 |       197,54 |          809448 |

Non sembra molto sensato considerare una corsa media una da meno di 3 miglia.

Pertanto sarebbe necessario impostare degli scaglioni fissi. 

Perché la segmentazione che si otterrebbe utilizzando un valore massimo e dividendolo in 3 non restituisce per nulla qualcosa di valido

es: 200km corsa massima, 0< short < 66 < medium <133 < long < max 

Impostando degli scaglioni 3, 12, max:

Mi sembra sia un buon compromesso e soprattutto non è dipendente dai dati
Previewing node 'boundaries':
| distance_category | min_distance | max_distance | number_of_trips |
| ----------------- | ------------ | ------------ | --------------- |
| short             |         0,01 |         3,00 |         1677368 |
| medium            |         3,01 |        12,00 |          571426 |
| long              |        12,01 |       197,54 |          179551 |