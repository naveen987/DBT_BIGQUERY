-- models/static_live_merged.sql

{{ config(materialized='table', alias='static_Live_Merged') }}

SELECT 
  'Static' AS source, 
  a.Ticker, 
  a.Open, 
  a.Close AS Close_Static, 
  a.High AS High_Static, 
  a.Low AS Low_Static, 
  a.`Adj-close`,
  CAST(a.Date AS DATE) AS Date,  -- Ensure Date is of type DATE
  a.Volume AS Volume_Static
FROM `dbt_tnataraju.Combined_static_data` a

UNION ALL

SELECT 
  'Transformed' AS source,
  b.Ticker,
  NULL AS Open, 
  b.Close AS Close_Transformed,
  b.High AS High_Transformed,
  b.Low AS Low_Transformed,
  NULL AS `Adj-close`, 
  CAST(b.Date AS DATE) AS Date,  -- Ensure Date is of type DATE
  b.Volume AS Volume_Transformed
FROM `dbt_tnataraju.Stock_data_transformation` b
