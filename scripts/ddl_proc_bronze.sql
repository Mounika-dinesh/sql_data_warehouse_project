use master;
create database datawarehouse;
use datawarehouse;

create schema bronze;

create schema silver;
go
create schema gold;
go

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);
GO

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);
GO

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);
GO

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
GO

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);
GO


create or alter procedure bronze.load_bronze as
Begin
	DECLARE @start_time Datetime, @end_time Datetime;
	Begin Try
		print '================================================';
		print 'Loading Bronze Layer';
		print '================================================';

		print '-------------------------------------------------';
		print 'Loading CRM Tables';
		print '-------------------------------------------------';

		Set @start_time =GETDATE();
		print '>> Truncating Table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;
		print '>> Inserting data into; bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		from 'C:\SQLData\cust_info.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		Set @end_time=getdate();
		print '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		print '-------------------------------------';

		BULK INSERT bronze.crm_prd_info
		from 'C:\SQLData\prd_info.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);

		BULK INSERT bronze.crm_sales_details
		from 'C:\SQLData\sales_details.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);


		print '-------------------------------------------------';
		print 'Loading ERP Tables';
		print '-------------------------------------------------';

		BULK INSERT bronze.erp_cust_az12
		from 'C:\SQLData\source_erp\cust_az12.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);


		BULK INSERT bronze.erp_loc_a101
		from 'C:\SQLData\source_erp\loc_a101.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);

		BULK INSERT bronze.erp_px_cat_g1v2
		from 'C:\SQLData\source_erp\px_cat_g1v2.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			TABLOCK
		);
		
	END TRY
	BEGIN CATCH
		PRINT '====================================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '====================================================='
	END CATCH
END

select * from bronze.crm_cust_info;


exec bronze.load_bronze
