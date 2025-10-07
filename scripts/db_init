/**********************************************************************************************
* Project: SQL Data Warehouse
* Script: DB_init.sql
* Author: Joao Santos
* Description:
*   This script initializes the SQL Server environment for the Data Warehouse project.
*   It creates the main database and defines the schemas for each Medallion layer:
*     - bronze  - Raw data from source systems
*     - silver  - Cleaned and standardized data ready for analytical processing
*     - gold    - Business-ready, aggregated, and modeled data
*
* Notes:
*   - It is assumed that no existing database named 'DataWarehouse' already exists.
*   - If it does, drop or rename it before running this script.
*
* Usage:
*   Run this script once to set up the database structure before loading any data.
*
* Date: 2025-10-07
**********************************************************************************************/


USE master;
GO

-- Create the DataWarehouse database
CREATE DATABASE DataWarehouse;

USE DataWarehouse;
GO

-- Create schemas for each layer (bronze, silver, gold)
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
