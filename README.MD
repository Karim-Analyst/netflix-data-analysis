# 🎬 Netflix Data Analysis (SQL)

## 📌 Project Overview
This project focuses on **cleaning and preparing Netflix content data** using SQL to make it **analysis-ready** for business insights.

The goal is to:
- Protect raw data
- Improve data quality
- Enable reliable aggregations, trends, and comparisons

---

## 🗂️ Data Layers

### 📥 Raw Table
- **Table**: `netflix1$`
- **Role**: Source of truth
- **Rule**: Never modified

### 🛠️ Cleaned Table
- **Table**: `net_backup`
- **Role**: Analysis-ready dataset
- **Usage**: All EDA and business queries

---

## 🧹 Cleaning Steps Completed

### 🛡️ 1. Raw Data Protection
- Created a full backup table to prevent accidental data loss

### 📅 2. Date Standardization
- Converted `date_added` from text → `DATE`
- Enables:
  - 📈 Time-series analysis
  - 📊 Year-over-year trends

### 📊 3. Content Type Validation
- Audited distribution of Movies vs TV Shows
- Checked for missing or invalid values

### 🧹 4. Text Cleanup
- Trimmed leading/trailing spaces from titles
- Prevents duplicates and join issues

### 🌍 5. Country Field Exploration
- Identified multi-country records (comma-separated values)
- Prepares data for future normalization

### 🎬 6. Director Field Normalization
- Replaced placeholder values (`'not given'`) with `NULL`
- Ensures accurate aggregations

---

## 📁 Repository Structure



---

## Next Steps
-Continue cleaning Cause it still on Progress.
-Exploratory Data Analysis (EDA)
-Country dominance insights
-Director & genre performance
-Content release trends over time
