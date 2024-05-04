{{ config(materialized='table', table_name='Static_Live_Merged') }}

-- First, aggregate data for each dataset
WITH AggregatedA AS (
    SELECT
        Date,
        Ticker,
        AVG(Open) AS Open,
        AVG(Close) AS Close,
        MAX(High) AS High,
        MIN(Low) AS Low,
        AVG(`Adj-close`) AS `Adj-close`,
        SUM(Volume) AS Volume
    FROM {{ ref('merged_data') }}
    GROUP BY Date, Ticker
),
AggregatedB AS (
    SELECT
        Date,
        Ticker,
        AVG(Open) AS Open, -- Assuming you might also have Open in this dataset
        AVG(Close) AS Close,
        MAX(High) AS High,
        MIN(Low) AS Low,
        SUM(Volume) AS Volume,
        SUM(Number_of_Transactions) AS Number_of_Transactions,
        AVG(Volume_Weighted_Average_Price) AS Volume_Weighted_Average_Price
    FROM {{ ref('Stock_data_transformation') }}
    GROUP BY Date, Ticker
)

-- Then perform the FULL OUTER JOIN on both Date and Ticker
SELECT
    COALESCE(a.Ticker, b.Ticker) AS Ticker,
    COALESCE(a.Open, b.Open) AS Open,
    COALESCE(a.Close, b.Close) AS Close,
    COALESCE(a.High, b.High) AS High,
    COALESCE(a.Low, b.Low) AS Low,
    COALESCE(a.`Adj-close`) AS `Adj-close`, -- Only from 'a' since 'b' does not have this column
    COALESCE(a.Date, b.Date) AS Date,
    COALESCE(a.Volume, b.Volume) AS Volume,
    b.Number_of_Transactions, -- Only from 'b'
    b.Volume_Weighted_Average_Price -- Only from 'b'
FROM AggregatedA a
FULL OUTER JOIN AggregatedB b
ON a.Date = b.Date AND a.Ticker = b.Ticker
