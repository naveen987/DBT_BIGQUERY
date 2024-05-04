-- models/static_live_merged.sql
 
{{ config(materialized='table',table_name='Static_Live_merged') }}
 
SELECT
  'Static' AS source,
  a.Ticker,
  a.Open,
  a.Close AS Close_Static,
  a.High AS High_Static,
  a.Low AS Low_Static,
  a.`Adj-close`,
  CAST(a.Date AS DATE) AS Date,  
  a.Volume AS Volume_Static,
  NULL AS Number_of_Transactions,  -- Placeholder for Number_of_Transactions
  NULL AS Volume_Weighted_Average_Price  -- Placeholder for Volume_Weighted_Average_Price
FROM {{ ref('merged_data') }} a  -- Using ref() to refer to the 'combined_static_data' model
 
UNION ALL
 
SELECT
  'Transformed' AS source,
  b.Ticker,
  b.Open,  -- No Open data in Transformed
  b.Close AS Close_Transformed,
  b.High AS High_Transformed,
  b.Low AS Low_Transformed,
  NULL AS `Adj-close`,  -- No Adj-close data in Transformed
  CAST(b.Date AS DATE) AS Date,  -- Ensure Date is of type DATE
  b.Volume AS Volume_Transformed,
  b.Number_of_Transactions,
  b.Volume_Weighted_Average_Price  -- Matching the column count
FROM {{ ref('Stock_data_transformation') }} b  -- Using ref() to refer to the 'stock_data_transformation' model