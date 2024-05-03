-- models/combined_static_data.sql

{{ config(materialized='table', alias='Combined_static_data') }}

SELECT 
  'TESLA' AS source, 
  Ticker, 
  Open, 
  Close, 
  High, 
  Low, 
  `Adj_Close` AS `Adj-close`, 
  Date, 
  Volume
FROM `dbt_tnataraju.TESLA_Transformed`
UNION ALL
SELECT 
  'NETFLIX' AS source, 
  Ticker, 
  Open, 
  Close, 
  High, 
  Low, 
  `Adj_Close` AS `Adj-close`, 
  Date, 
  Volume
FROM `dbt_tnataraju.NETFLIX_Transformed`
UNION ALL
SELECT 
  'NVIDIA' AS source, 
  Ticker, 
  Open, 
  Close, 
  High, 
  Low, 
  `Adj_Close` AS `Adj-close`, 
  Date, 
  Volume
FROM `dbt_tnataraju.NVIDIA_Transformed`
UNION ALL
SELECT 
  'AMAZON' AS source, 
  Ticker, 
  Open, 
  Close, 
  High, 
  Low, 
  `Adj_Close` AS `Adj-close`, 
  Date, 
  Volume
FROM `dbt_tnataraju.Amazon_Transformed`
UNION ALL
SELECT 
  'MICROSOFT' AS source, 
  Ticker, 
  Open, 
  Close, 
  High, 
  Low, 
  `Adj_Close` AS `Adj-close`, 
  Date, 
  Volume
FROM `dbt_tnataraju.Microsoft_Transformed`
UNION ALL
SELECT 
  'IBM' AS source, 
  Ticker, 
  Open, 
  Close, 
  High, 
  Low, 
  `Adj_Close` AS `Adj-close`, 
  Date, 
  Volume
FROM `dbt_tnataraju.IBM_Transformed`
UNION ALL
SELECT 
  'GOOGLE' AS source, 
  Ticker, 
  Open, 
  Close, 
  High, 
  Low, 
  `Adj_Close` AS `Adj-close`, 
  Date, 
  Volume
FROM `dbt_tnataraju.Google_Transformation`
UNION ALL
SELECT 
  'APPLE' AS source, 
  Ticker, 
  Open, 
  Close, 
  High, 
  Low, 
  `Adj_Close` AS `Adj-close`, 
  Date, 
  Volume
FROM `dbt_tnataraju.Apple_transformation`
