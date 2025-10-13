/* =============================================================================
   Project: Data Warehouse - Gold Layer (Views Creation)
   Author: João Santos
   Description:
       This script builds the **Gold Layer** of the Data Warehouse, 
       creating **dimension** and **fact views** that integrate and
       model data from the **Silver Layer**.

   Layers Overview:
   -------------------------------------------------------------------------
   - **Bronze Layer**: Raw ingestion from source systems (CRM, ERP, etc.)
   - **Silver Layer**: Cleansed, standardized, and deduplicated data
   - **Gold Layer**: Business-ready models for reporting and analytics

   Script Sections:
   -------------------------------------------------------------------------
   1. gold.dim_customers
      - Combines CRM and ERP customer data
      - Adds surrogate key (customer_key)
      - Normalizes gender, marital status, and links location data

   2. gold.dim_products
      - Integrates product info from CRM and ERP categories
      - Adds surrogate key (product_key)
      - Filters out inactive/historical products (prd_end_dt IS NULL)

   3. gold.fact_sales
      - Creates sales fact table
      - Links sales transactions with product and customer dimensions
      - Includes measures: sales_amount, quantity, price

   Notes:
   -------------------------------------------------------------------------
   - Uses `ROW_NUMBER()` for surrogate keys (dim tables)
   - Views are rebuilt if they already exist (`DROP VIEW` safeguard)
   - Aligns with Kimball’s dimensional modeling principles

   Last Updated: October 2025
   ============================================================================= */


-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key, -- Surrogate key
    ci.cst_id                          AS customer_id,
    ci.cst_key                         AS customer_number,
    ci.cst_firstname                   AS first_name,
    ci.cst_lastname                    AS last_name,
    la.cntry                           AS country,
    ci.cst_marital_status              AS marital_status,
    CASE 
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the primary source for gender
        ELSE COALESCE(ca.gen, 'n/a')  			   -- Fallback to ERP data
    END                                AS gender,
    ca.bdate                           AS birthdate,
    ci.cst_create_date                 AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
    ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
    ON ci.cst_key = la.cid;
GO

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key, -- Surrogate key
    pn.prd_id       AS product_id,
    pn.prd_key      AS product_number,
    pn.prd_nm       AS product_name,
    pn.cat_id       AS category_id,
    pc.cat          AS category,
    pc.subcat       AS subcategory,
    pc.maintenance  AS maintenance,
    pn.prd_cost     AS cost,
    pn.prd_line     AS product_line,
    pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL; -- Filter out all historical data
GO

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_key AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt  AS shipping_date,
    sd.sls_due_dt   AS due_date,
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id;
GO
