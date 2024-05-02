-- models/Apple_transformed.sql
{{ config(materialized='table', table_name='Microsoft_Transformed') }}

WITH source_data AS (
  SELECT
    ROUND(Open, 2) AS Open,
    ROUND(High, 2) AS High,
    ROUND(Low, 2) AS Low,
    ROUND(Close, 2) AS Close,
    ROUND(Adj_Close, 2) AS Adj_Close,
    Date,
    'MSFT' AS Ticker,
    Volume,
  FROM
    dbt_tnataraju.MICROSOFT
  WHERE
    EXTRACT(YEAR FROM Date) >= 2022
    ORDER BY
    Date ASC
)

SELECT
  *
FROM
  source_data