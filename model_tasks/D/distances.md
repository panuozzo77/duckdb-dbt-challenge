#### D. **Distance Analysis** [Mandatory]
- Segment trips by distance (`trip_distance`):
  - **Short**: 0-2 miles.
  - **Medium**: 2-5 miles.
  - **Long**: >5 miles.
- Calculate the average trip duration and total revenue for each segment.

Molto simile al mart precedente dim_trip__distance_classifier... Credo sia stato volutamente proposto (guardacaso)

Ho dovuto modificare nel modello dim_trip__distance_classifier i segmenti delle distanze delle corse perché precedentemente avevo impostato delle soglie 'personali'

Previewing node 'fct_trip__distance_analysis':
| distance_category |   total_revenue | avg_revenue | avg_duration | total_trips |
| ----------------- | --------------- | ----------- | ------------ | ----------- |
| long              | 16.709.874,600… |     93,065… |      51,467… |      179551 |
| medium            | 24.460.742,740… |     42,806… |      25,380… |      571426 |
| short             | 32.164.149,000… |     19,175… |      10,335… |     1677368 |