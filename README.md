# 🌾 Indian Orchards & Fruit Crops: Yield & Productivity Diagnostic (2018–2023)

![Project Status](https://img.shields.io/badge/Status-Completed-success)
![Tools](https://img.shields.io/badge/Tools-Python%20%7C%20SQL%20%7C%20Excel%20%7C%20Tableau-blue)
![Domain](https://img.shields.io/badge/Domain-AgriTech%20%26%20Supply%20Chain-green)

## 📌 Executive Project Overview
This repository contains a comprehensive **Area, Production, and Yield (APY) Diagnostic** covering India's major orchard and fruit crops (**Mango, Apple, Banana, Citrus, Grapes, and Guava**) across key producing states (**Jammu & Kashmir, Himachal Pradesh, Maharashtra, Andhra Pradesh, Uttar Pradesh, Karnataka, and Gujarat**).

The objective of this project is to eliminate reporting inconsistencies across agricultural data sources, establish a single source of truth for regional crop productivity, and bridge the gap between raw data engineering and executive policy decisions. The project executes an end-to-end 4-phase analytics pipeline:

1. **Python / Pandas Phase**: Data cleaning, text normalization, anomaly filtering, and physical yield feature engineering ($$\text{Yield (Tonnes/Ha)} = \frac{\text{Production (Tonnes)}}{\text{Area (Hectares)}}$$).
2. **SQL Relational Warehousing (SQLite)**: Window function ranking (`RANK() OVER`), regional aggregations, and district productivity profiling.
3. **Excel Spreadsheet Reconciliation**: Automated audit model using `SUMIF`, `VLOOKUP`, and nested `IF` logic, matching SQL database totals **unit-for-unit to 0.00 Tonnes difference**.
4. **Executive BI & Policy Report**: Structured narrative translating yield gaps into high-impact agronomic and cold-chain supply chain recommendations.

---

## 🗂️ Repository Directory Structure

```text
indian-orchards-fruit-yield-diagnostic/
│
├── README.md                          <-- Master project documentation & executive summary
├── EXECUTIVE_REPORT_ORCHARDS_APY.md   <-- Executive BI report & agronomic recommendations
│
├── data/
│   ├── india_fruit_apy_raw.csv        <-- Messy raw district crop data (670 initial records)
│   ├── india_fruit_apy_clean.csv      <-- Cleaned, feature-engineered dataset (645 records)
│   ├── agriculture_apy.db             <-- Primary SQLite relational database
│   └── district_yield_summary.csv     <-- Grouped district summary export for Tableau
│
├── sql/
│   └── 02_fruit_crop_queries.sql      <-- Production SQL queries (Window functions & rankings)
│
├── excel/
│   └── crop_yield_reconciliation.xlsx <-- Audit-ready Excel reconciliation workbook
│
└── notebooks/
    └── 01_fruit_crop_eda_cleaning.ipynb <-- Jupyter notebook covering Pandas cleaning & EDA
```

---

## ⚙️ Phase-by-Phase Execution & Methodology

### 🐍 Phase 1: Python Data Cleaning & Feature Engineering
* **Raw Audit**: Evaluated `india_fruit_apy_raw.csv` (670 initial rows). Identified 10 duplicate rows, 3 zero/negative cultivated area errors, and 12 missing production values.
* **Text Normalization**: Applied `.str.strip()` and `.str.title()` to clean state/crop casing (e.g., `' MAHARASHTRA '` -> `'Maharashtra'`).
* **Yield Metric**: Derived physical yield density (`yield_tonnes_per_ha`). Assigned productivity tiers based on national crop benchmarks (High, Moderate, Low Yield).
* **Output**: Saved verified 645-row dataset to `india_fruit_apy_clean.csv`.

### 🗄️ Phase 2: Relational SQL Warehousing & Analytics (SQLite)
* **Ingestion**: Created `agriculture_apy.db` and populated table `fruit_apy`.
* **Analytical Queries**: Executed SQL queries using `RANK() OVER (PARTITION BY crop ORDER BY avg_yield DESC)` to identify top-performing production clusters:
  * **Grapes**: Nashik, Maharashtra leads national economic yield density at **25.20 Tonnes/Ha**.
  * **Banana**: Jalgaon, Maharashtra & Anantapur, Andhra Pradesh lead volumetric production at **47.50 Tonnes/Ha**.
  * **Apple**: Baramulla & Shopian, J&K average **13.20 Tonnes/Ha**, outperforming Shimla, HP (**11.80 Tonnes/Ha**).

### 📊 Phase 3: Spreadsheet Audit & Reconciliation Model
* **Workbook**: Built `crop_yield_reconciliation.xlsx` featuring dynamic `SUMIF`, `VLOOKUP`, and nested `IF` status tags.
* **Reconciliation Result**: Calculated total national production across all 6 fruit crops (**18,618,813.20 Tonnes**) and verified against SQLite database queries. The reconciliation variance evaluates to **0.00 Tonnes**, proving complete data consistency.

### 💡 Phase 4: Key Strategic & Supply Chain Recommendations
1. **Mango Orchard Canopy Rejuvenation**: Mango occupies **30.4% of orchard land** (304,350 Ha) but yields only **10.33 Tonnes/Ha** (-1.61% below benchmark). Rejuvenation and High-Density Planting (HDP) transitions are required across UP and Maharashtra.
2. **Drip Fertigation Mandate**: Implement 100% micro-irrigation for Citrus and Guava clusters to stabilize yield fluctuations during dry spells.
3. **Cold-Chain Corridors**: Establish solar packhouses and refrigerated transit corridors from Jalgaon (Banana) and Nashik (Grapes) directly to metro distribution hubs to eliminate 15–20% post-harvest perishable waste.

---

## 🚀 How to Reproduce

1. **Python Environment**: Run the Jupyter Notebook to re-clean the raw CSV:
   ```bash
   jupyter notebook notebooks/01_fruit_crop_eda_cleaning.ipynb
   ```
2. **SQLite Database**: Query the database using standard SQLite CLI or Python `sqlite3`:
   ```bash
   sqlite3 data/agriculture_apy.db < sql/02_fruit_crop_queries.sql
   ```
3. **Excel Workbook**: Open `excel/crop_yield_reconciliation.xlsx` to inspect formulas and variance checks.

---
*Created as part of an Applied Data Intelligence & Business Analytics Portfolio.*

Author & Contact
Author: Somnath Banerjee
Role: Aspiring Business Analyst & Data Intelligence Specialist
LinkedIn: linkedin.com/in/somnath-banerjee-621720239
GitHub: banerjeesomnath1154-dotcom
