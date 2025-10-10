/**********************************************************************************************
* Project: SQL Data Warehouse
* Script: load_bronze.sql
* Author: Joao Santos
* Description:
*   This script loads raw data from CSV files into the Bronze Layer tables of the Data Warehouse.
*   It is implemented as a **stored procedure** (`bronze.load_bronze`) to allow daily execution.
*   Features include:
*     - Timing variables (@start_time, @end_time) to measure duration of each operation
*     - PRINT statements for logging progress
*     - TRY...CATCH block to handle errors gracefully
*     - Bulk insert operations for fast loading from CSVs
*
* Tables Loaded:
*   - bronze.crm_cust_info
*   - bronze.crm_prd_info
*   - bronze.crm_sales_details
*   - bronze.erp_cust_az12
*   - bronze.erp_loc_a101
*   - bronze.erp_px_cat_g1v2
*
* Notes:
*   - It is assumed that the tables exist and are emptyable (truncate is allowed).
*   - CSV file paths must be accessible from the SQL Server instance.
*   - Any existing data will be truncated before loading new data.
*
* Usage:
*   EXEC bronze.load_bronze; -- Execute the procedure to load all Bronze Layer tables
**********************************************************************************************/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS -- create as a procedure to run this daily
BEGIN
	-- using @start_time and @end_time variables to get the duration of every comand
	DECLARE @start_time DATETIME, @end_time DATETIME;

	-- using TRY to work on eventual erros
	BEGIN TRY
		PRINT '==============================';
		PRINT 'Loading Bronze Layer';
		PRINT '==============================';

		PRINT '------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------';

		SET @start_time = GETDATE();
		-- first make the table empty
		PRINT '>> Truncationg Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		--we are using the bulk insert because it's way faster then the tipical insert and it inserts with 1 opertation
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\santo\Ambiente de Trabalho\My Data Warehouse\data\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2, --the first row is the columns names
			FIELDTERMINATOR = ',', -- the delimeter is ","
			TABLOCK --lock the table while doing the bulk insert
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncationg Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\santo\Ambiente de Trabalho\My Data Warehouse\data\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';



		SET @start_time = GETDATE();
		PRINT '>> Truncationg Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details 
		FROM 'C:\Users\santo\Ambiente de Trabalho\My Data Warehouse\data\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',', 
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';
		PRINT '';
		PRINT '';

		PRINT '------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncationg Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\santo\Ambiente de Trabalho\My Data Warehouse\data\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncationg Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\santo\Ambiente de Trabalho\My Data Warehouse\data\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncationg Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\santo\Ambiente de Trabalho\My Data Warehouse\data\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------';

	END TRY
	-- writing an output in case of an error
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_MESSAGE() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END

EXEC bronze.load_bronze
