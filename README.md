# 🧩 SQL Data Warehouse

This project focuses on building a small **Data Warehouse in SQL Server**, modeled in a **Star Schema** (fact and dimension tables) to practice **advanced SQL** and **data modeling**. 🚀  

The goal is to apply **Data Engineering fundamentals**, from schema design to writing optimized queries, while documenting the entire process.

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
| **Definition** | Raw & unprocessed data as-is from sources |
| **Objective** | Traceability & debugging |
| **Object Type** | Tables |
| **ETL Process** | Extract & Load *(Batch Processing, Full Load, Truncate & Insert)* |
| **Data Model** | None *(as-is)* |
| **Target Audience** | Data Engineers |

---

### 🥈 Silver Layer — Cleaned & Standardized Data

> The **Silver Layer** focuses on **cleansing, standardization, normalization**, and **enrichment** to ensure consistent and reliable data across systems.  
> It represents **trusted**, well-structured data that is ready for **analytical transformations** and business consumption.

| 🔍 Property | 💡 Description |
|-------------|----------------|
| **Definition** | Clean & standardized data |
| **Objective** | Prepare data for analysis |
| **Object Type** | Tables |
| **ETL Process** | Extract, Load *(Batch Processing, Full Load, Truncate & Insert)*, Transformations *(Data Cleansing, Data Standardization, Data Normalization, Derived Columns, Data Enrichment)* |
| **Data Model** | None *(as-is)* |
| **Target Audience** | Data Engineers & Data Analysts |

---

### 🥇 Gold Layer — Business-Ready Data

> The **Gold Layer** contains **aggregated, integrated, and business-ready datasets**, modeled in **Star Schema** or other analytical formats.  
> This layer is consumed by **BI tools**, **ad-hoc SQL queries**, and **machine learning pipelines**.

| 🔍 Property | 💡 Description |
|-------------|----------------|
| **Definition** | Business-ready data |
| **Objective** | Prepare data for reporting & business analysis |
| **Object Type** | Views |
| **ETL Process** | Extract & Transform *(Data Integrations, Aggregations, Business Logic)* |
| **Data Model** | Star Schema, Flat Table, Aggregated Table |
| **Target Audience** | Data Analysts & Business Users |

The warehouse is structured in **three layers**, each with a specific purpose in preparing data for analysis and reporting.  
Data flows sequentially from sources → ETL processes → Bronze → Silver → Gold → consumption layer, enabling scalable analytics and reliable decision-making.

---

## ⚙️ ETL Process Used

The project implements a **custom ETL pipeline** in SQL to orchestrate data flow across all layers.  
It follows a **full extraction–load strategy** with data transformation and standardization logic applied between stages.

### **Extraction**
- Pull extraction from source systems  
- Full extraction (no incremental loads)  
- File parsing from structured CSV inputs  

### **Transformation**
- Data enrichment  
- Data integration across ERP and CRM systems  
- Derived columns creation  
- Data aggregations  
- Business rules & logic application  
- Data normalization & standardization  
- Duplicate removal  
- Data filtering  
- Handling missing or null values  
- Handling invalid values  
- Removing unwanted spaces  
- Data type casting  
- Outlier detection and validation  

### **Load**
- Batch loading between layers  
- Full reload (truncate & insert pattern)  
- Slowly Changing Dimension Type 1 *(overwrite on updates)*  

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

---

## 🧠 Inspiration

This project was inspired by the YouTube video  
🎥 **"SQL Data Warehouse from Scratch | Full Hands-On Data Engineering Project"**  
by **Baraa** — whose content provided a great foundation for practicing end-to-end Data Engineering concepts.
