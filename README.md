# SQL Data Warehouse


This project focuses on building a small Data Warehouse in SQL Server, modeled in a Star Schema (fact and dimension tables) to practice advanced SQL and data modeling. 🚀

The goal is to apply Data Engineering fundamentals, from schema design to writing optimized queries, while documenting the entire process.

---
## 📖 Project Overview

This project focuses on building a **modern data warehouse** with a clear **Medallion Architecture** (🥉 Bronze → 🥈 Silver → 🥇 Gold), enabling scalable analytics and reliable insights.

**Key Components:**

- **Data Architecture:** Designing a **Medallion Architecture** with Bronze, Silver, and Gold layers.  
- **ETL Pipelines:** Extracting, transforming, and loading data from source systems into the warehouse.  
- **Data Modeling:** Developing **fact and dimension tables** optimized for analytical queries.  
- **Analytics & Reporting:** Creating **SQL-based reports and dashboards** to generate actionable insights.


---
## 🧱 Data Architecture

This data warehouse is organized into **three main layers** — Bronze, Silver, and Gold — each serving a specific purpose in the journey from raw data to business-ready insights.


### 🥉 Bronze Layer — Raw Data

> The **Bronze Layer** stores **raw, unprocessed data** exactly as it comes from source systems (e.g., CRM, ERP, or flat files).  
> It acts as the **single source of truth** for historical records and supports **full reloads** or **batch processing**.

| 🔍 Property | 💡 Description |
|-------------|----------------|
| **Object Type** | Tables |
| **ETL Process** | Extract & Load *(Batch Processing, Full Load, Truncate & Insert)* |
| **Data Model** | None *(as-is)* |

### 🥈 Silver Layer — Cleaned & Standardized Data

> The **Silver Layer** focuses on **cleansing, standardization, normalization**, and **enrichment** to ensure consistent and reliable data across systems.  
> It represents **trusted**, well-structured data that is ready for **analytical transformations** and business consumption.

| 🔍 Property | 💡 Description |
|-------------|----------------|
| **Object Type** | Tables |
| **ETL Process** | Extract, Load *(Batch Processing, Full Load, Truncate & Insert)*, Transformations *(Data Cleansing, Data Standardization, Data Normalization, Derived Columns, Data Enrichment)* |
| **Data Model** | None *(as-is)* |

### 🥇 Gold Layer — Business-Ready Data

> The **Gold Layer** contains **aggregated, integrated, and business-ready datasets**, modeled in **Star Schema** or other analytical formats.  
> This layer is consumed by **BI tools**, **ad-hoc SQL queries**, and **machine learning pipelines**.

| 🔍 Property | 💡 Description |
|-------------|----------------|
| **Object Type** | Views |
| **ETL Process** | Extract & Transform *(Data Integrations, Aggregations, Business Logic)* |
| **Data Model** | Star Schema, Flat Table, Aggregated Table |

Data flows sequentially from sources → ETL processes → Bronze → Silver → Gold → consumption layer, enabling scalable analytics and reliable decision-making.

---
## 🎯 Project Requirements

### Objective
Develop a **modern data warehouse** using **SQL Server** to consolidate sales data, enabling **analytical reporting** and **informed decision-making**.

### Specifications

- **Data Sources:** Import data from **two source systems** (ERP and CRM) provided as **CSV files**.  
- **Data Quality:** Cleanse and resolve **data quality issues** prior to analysis.  
- **Integration:** Combine both sources into a **single, user-friendly data model** designed for analytical queries.  
- **Scope:** Focus on the **latest dataset only**; historization of data is **not required**.  
- **Documentation:** Provide **clear documentation** of the data model to support both **business stakeholders** and **analytics teams**.


