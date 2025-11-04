{{ config(
    tags=['inspecting']
)}}

WITH raw_counts AS (
    SELECT
        vendor_id,
        COUNT(*) AS count_raw
    FROM {{ ref('stg_trip__base') }}
    GROUP BY vendor_id
),

cleaned_counts AS (
    SELECT
        vendor_id,
        COUNT(*) AS count_cleaned
    FROM {{ ref('stg_trip__cleaned') }}
    GROUP BY vendor_id
),

speed_filtered_counts AS (
    SELECT
        vendor_id,
        COUNT(*) AS count_speed_filtered
    FROM {{ ref('stg_trip__speed_filtered') }}
    GROUP BY vendor_id
)

SELECT
    raw.vendor_id,
    raw.count_raw,
    
    COALESCE(clean.count_cleaned, 0) AS count_cleaned,
    COALESCE(speed.count_speed_filtered, 0) AS count_speed_filtered,
    
    (raw.count_raw - COALESCE(clean.count_cleaned, 0)) AS discarded_at_cleaning,
    (COALESCE(clean.count_cleaned, 0) - COALESCE(speed.count_speed_filtered, 0)) AS discarded_at_speed_filter,
    
    ROUND((COALESCE(speed.count_speed_filtered, 0) * 100.0) / NULLIF(raw.count_raw, 0), 2) AS percentage_remaining

FROM raw_counts AS raw
LEFT JOIN cleaned_counts AS clean ON raw.vendor_id = clean.vendor_id
LEFT JOIN speed_filtered_counts AS speed ON raw.vendor_id = speed.vendor_id
ORDER BY raw.vendor_id