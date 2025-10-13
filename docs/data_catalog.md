# 🗂️ Data Catalog for Gold Layer

## Overview
The **Gold Layer** is the business-level data representation, structured to support analytical and reporting use cases.  
It consists of **dimension** and **fact views** derived from the **Silver Layer**, following **Kimball’s dimensional modeling** principles.

---

### 1. **gold.dim_customers**
**Purpose:** Stores customer details enriched with demographic and geographic data.

| Column Name      | Data Type     | Description                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| customer_key     | INT           | Surrogate key uniquely identifying each customer record in the dimension view.               |
| customer_id      | INT           | Unique numerical identifier assigned to each customer (`cst_id` from CRM).                   |
| customer_number  | VARCHAR(50)   | Alphanumeric identifier representing the customer (`cst_key`).                               |
| first_name       | NVARCHAR(50)  | The customer's first name.                                                                   |
| last_name        | NVARCHAR(50)  | The customer's last name.                                                                    |
| country          | VARCHAR(50)   | Country of residence, from ERP location table.                                               |
| marital_status   | VARCHAR(1)    | Marital status code of the customer (e.g., 'M', 'S').                                        |
| gender           | VARCHAR(10)   | Customer’s gender (e.g., 'M', 'F', 'n/a'), prioritized from CRM data.                        |
| birthdate        | VARCHAR(10)   | Birth date from ERP customer data (`bdate`), stored as a string (format: YYYY-MM-DD).        |
| create_date      | DATE          | Date when the customer record was created in CRM.                                            |

---

### 2. **gold.dim_products**
**Purpose:** Provides detailed information about products and their classification.

| Column Name          | Data Type     | Description                                                                                   |
|----------------------|---------------|-----------------------------------------------------------------------------------------------|
| product_key          | INT           | Surrogate key uniquely identifying each product record in the dimension view.                 |
| product_id           | INT           | Unique identifier for each product (`prd_id` from CRM).                                       |
| product_number       | VARCHAR(50)   | Product code or key (`prd_key`).                                                              |
| product_name         | VARCHAR(50)   | Name of the product (`prd_nm`).                                                               |
| category_id          | VARCHAR(50)   | Identifier of the product’s category (`id` from ERP).                                         |
| category             | VARCHAR(50)   | High-level category name (e.g., 'Bikes', 'Accessories').                                     |
| subcategory          | VARCHAR(50)   | More specific product classification within the category.                                     |
| maintenance          | VARCHAR(3)    | Indicates if maintenance is required (e.g., 'Yes', 'No').                                    |
| cost                 | INT           | Product cost from CRM data (`prd_cost`).                                                      |
| product_line         | VARCHAR(50)   | The product line or family (e.g., 'Road', 'Mountain').                                       |
| start_date           | DATE          | Product launch or availability date (`prd_start_dt`).                                         |

---

### 3. **gold.fact_sales**
**Purpose:** Contains transactional sales data linked to products and customers.

| Column Name     | Data Type     | Description                                                                                   |
|-----------------|---------------|-----------------------------------------------------------------------------------------------|
| order_number    | VARCHAR(50)   | Unique alphanumeric identifier for each sales order (`sls_ord_num`).                          |
| product_key     | INT           | Foreign key linking to the product dimension.                                                 |
| customer_key    | INT           | Foreign key linking to the customer dimension.                                                |
| order_date      | INT           | Order date stored as an integer in YYYYMMDD format (`sls_order_dt`).                          |
| shipping_date   | INT           | Date when the order was shipped (`sls_ship_dt`), in YYYYMMDD format.                          |
| due_date        | INT           | Due date for payment or delivery (`sls_due_dt`), in YYYYMMDD format.                          |
| sales_amount    | INT           | Total sales value for the transaction (`sls_sales`).                                          |
| quantity        | INT           | Number of units sold (`sls_quantity`).                                                        |
| price           | INT           | Unit price of the product (`sls_price`).                                                      |

---

## ✅ Notes
- The Gold Layer is built as **SQL Views** referencing Silver Layer tables.  
- **Surrogate keys** (`ROW_NUMBER()`) are used in dimensions for analytics efficiency.  
- **Data joins** integrate CRM and ERP sources for unified customer and product insights.  
- The **fact_sales** table enables slicing by both product and customer dimensions.
