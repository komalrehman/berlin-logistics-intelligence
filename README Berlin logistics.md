# Berlin Logistics Intelligence

End-to-end logistics data analytics project using Python, SQL, and Looker Studio.

## Project Overview

Berlin Logistics Intelligence is an end-to-end data analytics project focused on shipment operations in Berlin. The project demonstrates a complete workflow from raw data cleaning and validation to exploratory analysis, SQL analysis, and interactive dashboarding.

### Tools
- Python (Pandas)
- SQLite / SQL
- Looker Studio
- Google Colab

## Data Preparation & Quality

The raw dataset contained 510 shipment records and 7 columns. Data preparation included parsing the malformed CSV structure, converting numeric fields to appropriate data types, removing 1 exact duplicate record, normalizing PLZ values to a 5-character text format, checking for missing values, checking zero values in key numeric fields, and validating the cleaned dataset before analysis.

The final dataset contains **509 shipment records** with **226 unique PLZ values**.

## Key Findings

- 509 shipments across 226 unique PLZ areas.
- Total shipment weight: **52,246**.
- Average shipment weight: **102.64**; median: **52**, indicating a right-skewed distribution.
- `Lieferung,Service` is the most common order type (about 57% of shipments).
- 42 shipments (8.25%) have shipment weight >= 300.
- Weight and distance show almost no linear correlation (r ≈ -0.012).
- Packaging units show a moderate positive association with shipment weight (r ≈ 0.31).

## SQL Analysis

The cleaned dataset was loaded into a SQLite database and analyzed using SQL. The analysis covers shipment volume by order type, shipment weight by order type, weight/distance correlation, heavy shipments, top PLZ areas, packaging units vs. weight, and overall KPIs.

The SQL queries are stored in `analysis.sql`.

## Dashboard

The project includes an interactive Looker Studio dashboard with an Executive Overview and an Operational Analysis page.

## Limitations & Notes

- The dataset does not include a postal-code reference table, so PLZ values were normalized to a 5-character format without inventing geographic corrections.
- Zero values were retained because the source data does not provide enough information to determine whether they represent valid operational values or unknown measurements.
- Correlation analysis indicates association only and does not imply causation.
- The dashboard is intended for operational exploration and portfolio demonstration rather than real-world logistics decision-making.

## Project Outputs

- `berlin_logistics_clean.csv` — cleaned dataset
- `berlin_logistics_dashboard.csv` — dashboard-ready dataset
- `berlin_logistics.db` — SQLite database
- `analysis.sql` — SQL analysis queries
- Google Colab notebook — project workflow and analysis
- Looker Studio dashboard — interactive visualization
