-- models/transformed_stock_data.sql

{{ config(materialized='table') }}

WITH renamed_columns AS (
  SELECT 
    CAST(CASE WHEN ABS(Open_Price * 100 - ROUND(Open_Price * 100)) < 0.01 THEN Open_Price ELSE ROUND(Open_Price, 2) END AS FLOAT64) AS Price,
    CAST(CASE WHEN ABS(Close_Price * 100 - ROUND(Close_Price * 100)) < 0.01 THEN Close_Price ELSE ROUND(Close_Price, 2) END AS FLOAT64) AS Close,
    CAST(CASE WHEN ABS(High_Price * 100 - ROUND(High_Price * 100)) < 0.01 THEN High_Price ELSE ROUND(High_Price, 2) END AS FLOAT64) AS High,
    CAST(CASE WHEN ABS(Low_Price * 100 - ROUND(Low_Price * 100)) < 0.01 THEN Low_Price ELSE ROUND(Low_Price, 2) END AS FLOAT64) AS Low,
    CAST(ROUND(Volume_Weighted_Average_Price, 2) AS FLOAT64) AS Volume_Weighted_Average_Price,
    Volume,  -- Formats Volume with commas as thousand separators
    CAST(Number_of_Transactions AS INT64) AS Number_of_Transactions,
    CAST(Ticker AS STRING) AS Ticker,
    Date
  FROM 
    dbt_tnataraju.stock_data
)

SELECT * FROM renamed_columns
