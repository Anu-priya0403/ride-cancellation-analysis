CREATE DATABASE IF NOT EXISTS CAPSTONE_DB;
USE DATABASE CAPSTONE_DB;
CREATE SCHEMA IF NOT EXISTS CAPSTONE_ARPRIYA04;
USE SCHEMA CAPSTONE_ARPRIYA04;
CREATE TABLE IF NOT EXISTS gold_ride_cancellation_metrics (
    city STRING,
    ride_month DATE,
    total_rides INT,
    total_cancellations INT,
    cancellation_rate_pct FLOAT,
    total_completed_revenue FLOAT
);

CREATE STAGE IF NOT EXISTS stage_ride_cancellations;


COPY INTO gold_ride_cancellation_metrics
FROM @stage_ride_cancellations/gold_ride_cancellation_metrics.csv
FILE_FORMAT = (
    TYPE = 'CSV' 
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' 
    SKIP_HEADER = 1
);
SELECT * 
FROM gold_ride_cancellation_metrics 
ORDER BY cancellation_rate_pct DESC;
DESCRIBE TABLE gold_ride_cancellation_metrics;

-- Step 1: Drop and recreate the table cleanly
DROP TABLE IF EXISTS gold_ride_cancellation_metrics;

CREATE TABLE gold_ride_cancellation_metrics (
    city STRING,
    ride_month DATE,
    total_rides INT,
    total_cancellations INT,
    cancellation_rate_pct FLOAT,
    total_completed_revenue FLOAT
);

-- Step 2: Load data from your stage
COPY INTO gold_ride_cancellation_metrics
FROM @stage_ride_cancellations/
FILE_FORMAT = (
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
)
ON_ERROR = 'CONTINUE';

-- Step 3: Verify the data
SELECT * 
FROM gold_ride_cancellation_metrics 
ORDER BY cancellation_rate_pct DESC;

SELECT * FROM gold_ride_cancellation_metrics ORDER BY cancellation_rate_pct DESC;

SELECT * 
FROM gold_ride_cancellation_metrics 
ORDER BY cancellation_rate_pct DESC;