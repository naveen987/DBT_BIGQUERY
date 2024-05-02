-- models/Apple_transformed.sql
{{ config(materialized='table', table_name='IBM_Transformed') }}

WITH source_data AS (
  SELECT
    ROUND(Open, 2) AS Open,
    ROUND(High, 2) AS High,
    ROUND(Low, 2) AS Low,
    ROUND(Close, 2) AS Close,
    ROUND(Adj_Close, 2) AS Adj_Close,
    Date,
    Volume,
    'IBM' AS Ticker
  FROM
    dbt_tnataraju.IBM
  WHERE
    EXTRACT(YEAR FROM Date) >= 2022
  ORDER BY
    Date ASC
)

SELECT
  *
FROM
  source_data