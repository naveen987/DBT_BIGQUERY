-- models/Apple_transformed.sql
{{ config(materialized='table', table_name='AMAZON_Transformed') }}

WITH source_data AS (
  SELECT
    ROUND(Open, 2) AS Open,
    ROUND(High, 2) AS High,
    ROUND(Low, 2) AS Low,
    ROUND(Close, 2) AS Close,
    ROUND(adjusted_close, 2) AS Adj_Close,
    Date,
    CAST(Volume AS INT64) AS Volume,
    'AMZN' AS Ticker
  FROM
    dbt_tnataraju.AMAZON
  WHERE
    EXTRACT(YEAR FROM Date) >= 2022
  ORDER BY
    Date ASC
)

SELECT
  Open,
  High,
  Low,
  Close,
  Adj_Close,
  Date,
  Volume,
  Ticker
FROM
  source_data