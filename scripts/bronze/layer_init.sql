/**********************************************************************************************
* Project: SQL Data Warehouse
* Script: 02_create_bronze_tables.sql
* Author: Joao Santos
* Description:
*   This script creates the base tables for the Bronze Layer in the Data Warehouse.
*   The Bronze Layer stores raw data ingested directly from the source systems (CRM and ERP)
*   without applying any transformations. It acts as the single source of truth for raw data.
*
* Tables Created:
*   - bronze.crm_cust_info       → Customer information (CRM)
*   - bronze.crm_prd_info        → Product information (CRM)
*   - bronze.crm_sales_details   → Sales details (CRM)
*   - bronze.erp_cust_az12       → Customer base (ERP)
*   - bronze.erp_loc_a101        → Location data (ERP)
*   - bronze.erp_px_cat_g1v2     → Product category data (ERP)
*
* Notes:
*   - It is assumed that none of these tables already exist in the database.
*   - If they do, drop or rename them before executing this script.
*   - These tables are created under the 'bronze' schema.
*
* Usage:
*   Run this script after initializing the database and creating the schemas.
**********************************************************************************************/

CREATE TABLE bronze.crm_cust_info(
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status VARCHAR(1),
	cst_gndr VARCHAR(1),
	cst_create_date DATE
);

CREATE TABLE bronze.crm_prd_info(
	prd_id INT,
	prd_key VARCHAR(50),
	prd_nm VARCHAR(50),
	prd_cost INT,
	prd_line VARCHAR(1),
	prd_start_dt DATE,
	prd_end_dt DATE
);

CREATE TABLE bronze.crm_sales_details(
  sls_ord_num VARCHAR(50),
  sls_prd_key VARCHAR(50),
  sls_cust_id INT,
  sls_order_dt INT,
  sls_ship_dt INT,
  sls_due_dt INT,
  sls_sales INT,
  sls_quantity INT,
  sls_price INT
);

CREATE TABLE bronze.erp_cust_az12(
  cid VARCHAR(50),
  bdate VARCHAR(10),
  gen VARCHAR(10)
);

CREATE TABLE bronze.erp_loc_a101(
  cid VARCHAR(50),
  cntry VARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2(
  id VARCHAR(50),
  cat VARCHAR(50),
  subcat VARCHAR(50),
  maintenance VARCHAR(3)
);
