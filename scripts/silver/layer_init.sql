/********************************************************************************************
    Project: Data Warehouse - Silver Layer Initialization
    Author: João Santos
    Layer: Silver
    Description:
        This script creates the Silver layer tables for the Data Warehouse.
        The Silver layer stores cleaned and standardized data transformed 
        from the Bronze layer, adding metadata columns for tracking purposes.

    Notes:
        - Each table mirrors its Bronze counterpart, with normalized data.
        - The column [dwh_create_date] is added to track load timestamps.
        - Designed to run in SQL Server.

    Tables created:
        • silver.crm_cust_info
        • silver.crm_prd_info
        • silver.crm_sales_details
        • silver.erp_cust_az12
        • silver.erp_loc_a101
        • silver.erp_px_cat_g1v2
********************************************************************************************/


CREATE TABLE silver.crm_cust_info(
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status VARCHAR(1),
	cst_gndr VARCHAR(1),
	cst_create_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE() -- add metadata
);

CREATE TABLE silver.crm_prd_info(
	prd_id INT,
	prd_key VARCHAR(50),
	prd_nm VARCHAR(50),
	prd_cost INT,
	prd_line VARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE silver.crm_sales_details(
	sls_ord_num VARCHAR(50),
	sls_prd_key VARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE silver.erp_cust_az12(
	cid VARCHAR(50),
	bdate VARCHAR(10),
	gen VARCHAR(10),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE silver.erp_loc_a101(
	cid VARCHAR(50),
	cntry VARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE silver.erp_px_cat_g1v2(
	id VARCHAR(50),
	cat VARCHAR(50),
	subcat VARCHAR(50),
	maintenance VARCHAR(3),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
