{{ config(materialized='table', table_name='Live_data_Transformed') }}

WITH formatted_columns AS (
  SELECT 
    CAST(CASE WHEN ABS(Open * 100 - ROUND(Open * 100)) < 0.01 THEN Open ELSE ROUND(Open, 2) END AS FLOAT64) AS Open,
    CAST(CASE WHEN ABS(Close * 100 - ROUND(Close * 100)) < 0.01 THEN Close ELSE ROUND(Close, 2) END AS FLOAT64) AS Close,
    CAST(CASE WHEN ABS(High * 100 - ROUND(High * 100)) < 0.01 THEN High ELSE ROUND(High, 2) END AS FLOAT64) AS High,
    CAST(CASE WHEN ABS(Low * 100 - ROUND(Low * 100)) < 0.01 THEN Low ELSE ROUND(Low, 2) END AS FLOAT64) AS Low,
    CAST(ROUND(Volume_Weighted_Average_Price, 2) AS FLOAT64) AS Volume_Weighted_Average_Price,
    Volume,  -- Keeping Volume as it is
    CAST(Number_of_Transactions AS INT64) AS Number_of_Transactions,
    CAST(Ticker AS STRING) AS Ticker,
    Date
  FROM 
    dbt_tnataraju.from_gcs
)

SELECT * FROM formatted_columns
