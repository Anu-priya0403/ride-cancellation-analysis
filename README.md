# Ride Cancellation Analysis

**Student Name:** Anu Priya Yaduvanshi  
**Roll Number:** 2305601  
**Batch:** Databricks & Snowflake 2026  
**Submitted To:** Dr. Kanthi Kiran Sirra  

---

## Project Overview
The **Ride Cancellation Analysis** pipeline processes raw ride-hailing transaction data to extract business-critical operational metrics, focusing on monthly ride cancellation rates and completed revenues across different cities. 

This end-to-end data engineering pipeline processes raw transactional data through a Databricks Medallion architecture and stages executive summary metrics into Snowflake for analytical reporting.

---

## System Architecture & Data Flow
1. **Bronze Layer (Databricks Delta):** Raw transactional CSV files ingested with added ingestion timestamps and source file metadata.
2. **Silver Layer (Databricks PySpark):** Data deduplication on `ride_id`, schema standardization, and quality checks (null key filtering).
3. **Gold Layer (Databricks PySpark):** Business aggregations computed by city and month, calculating total rides, total cancellations, cancellation percentage (`cancellation_rate_pct`), and net completed revenue.
4. **Staging & Export:** Gold metrics exported via Databricks Unity Catalog Volumes as CSV files.
5. **Serving Layer (Snowflake):** CSV metrics staged into `@stage_ride_cancellations` and bulk loaded into target table `CAPSTONE_DB.CAPSTONE_ARPRIYA04.GOLD_RIDE_CANCELLATION_METRICS` via SQL `COPY INTO` commands for fast analytical querying.

---

## Target Table Schema (`GOLD_RIDE_CANCELLATION_METRICS`)
* `city` (VARCHAR): Geographical operational market
* `ride_month` (DATE): Monthly aggregate timestamp
* `total_rides` (NUMBER): Total requested rides
* `total_cancellations` (NUMBER): Total cancelled rides
* `cancellation_rate_pct` (FLOAT): Calculated cancellation percentage
* `total_completed_revenue` (FLOAT): Sum of revenue from completed trips

---

## Repository Structure
* `01_bronze_ingestion.py` — Raw data ingestion script
* `02_silver_cleaning.py` — PySpark cleaning and validation logic
* `03_gold_aggregation.py` — Gold layer KPI metric calculations
* `snowflake_setup_and_load.sql` — Snowflake table DDL and `COPY INTO` ingestion script
* `gold_ride_cancellation_metrics.csv` — Processed 30-row Gold summary dataset
* `README.md` — Project documentation
