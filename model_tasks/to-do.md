## Tasks: Required Models

### 1. **Staging Models** [Mandatory]
Create staging models to clean and enrich the data by:
- **Timestamp formatting**: Standardize date/time formats and calculate:
  - Trip duration in minutes.
- **Data cleaning**: Remove rows with implausible values (e.g., negative `trip_distance`, `total_amount` ≤ 0).
- **Additional flags**:
  - Identify if the trip was prepaid (`payment_type` = 2).
  - Classify trips based on distance (e.g., short, medium, long).

### 2. **Data Marts**
Create the following **marts** to provide insights:

#### A. **Trips by Time of Day** [Mandatory]
- Calculate the total number of trips and total revenue (`total_amount`) for different time slots:
  - Morning (5:00-12:00)
  - Afternoon (12:00-17:00)
  - Evening (17:00-22:00)
  - Night (22:00-5:00)

#### B. **Top 5 Pickup Zones** [Mandatory]
- Identify the top 5 pickup zones (`PULocationID`) with:
  - The highest number of trips.
  - The highest total revenue.

#### C. **Driver/Rate Performance** [Mandatory]
- Analyze **tips**:
  - Calculate the average tip percentage (`tip_amount / total_amount`) for each `VendorID`.

#### D. **Distance Analysis** [Mandatory]
- Segment trips by distance (`trip_distance`):
  - **Short**: 0-2 miles.
  - **Medium**: 2-5 miles.
  - **Long**: >5 miles.
- Calculate the average trip duration and total revenue for each segment.
