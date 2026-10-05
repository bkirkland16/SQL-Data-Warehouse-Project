/*
-- Bronze Layer Data Load Stored Procedure

Script Purpose:
	This script creates a stored procedure for empyting the bronze layer data tables and then populating them with the data
	found in the files called out in the 'From' lines. Additionally the Try Catch will catch any errors in the Stored Procedure
	and revert the Truncate should the Insert fail. Addtionally this script measures the duration of each step of the procedure
	and the duration of the total procedure in seconds.
	*/

Create or Alter Procedure bronze.load_bronze As
Begin
	Declare @start_time Datetime, @end_time Datetime, @batch_start_time Datetime, @batch_end_time Datetime;
	Set Xact_Abort On;
Begin Try
Set @batch_start_time = GetDate();
Begin Transaction;

		Print '====================================';
		Print 'Loading Bronze Layer';
		Print '====================================';

		Print '------------------------------------';
		Print 'Loading CRM Tables';
		Print '------------------------------------';

		Set @start_time = GetDate();
		Print '>> Truncating Table: [bronze].[crm_cust_info]';
		Truncate Table [bronze].[crm_cust_info];
		Print '>> Inserting Data Into: [bronze].[crm_cust_info]';
		Bulk Insert [bronze].[crm_cust_info]
		From  'C:\SQL Datawarehouse Project Files\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		With (
			Firstrow = 2,
			Fieldterminator = ',',
			Tablock
		);
		Set @end_time = GetDate();
		Print '>> Load Duration: '+Cast(DateDiff(second, @start_time, @end_time) As Nvarchar) + ' seconds';
		Print '------------------------------------';

		Set @start_time = GetDate();
		Print '>> Truncating Table: [bronze].[crm_prd_info]';
		Truncate Table [bronze].[crm_prd_info];
		Print '>> Inserting Data Into: [bronze].[crm_prd_info]';
		Bulk Insert [bronze].[crm_prd_info]
		From  'C:\SQL Datawarehouse Project Files\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		With (
			Firstrow = 2,
			Fieldterminator = ',',
			Tablock
		);
		Set @end_time = GetDate();
		Print '>> Load Duration: '+Cast(DateDiff(second, @start_time, @end_time) As Nvarchar) + ' seconds';
		Print '------------------------------------';

		Set @start_time = GetDate();
		Print '>> Truncating Table: [bronze].[crm_sales_details]';
		Truncate Table [bronze].[crm_sales_details];
		Print '>> Inserting Data Into: [bronze].[crm_sales_details]';
		Bulk Insert [bronze].[crm_sales_details]
		From  'C:\SQL Datawarehouse Project Files\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		With (
			Firstrow = 2,
			Fieldterminator = ',',
			Tablock
		);
			Set @end_time = GetDate();
		Print '>> Load Duration: '+Cast(DateDiff(second, @start_time, @end_time) As Nvarchar) + ' seconds';
		Print '------------------------------------';

		Print '------------------------------------';
		Print 'Loading ERP Tables';
		Print '------------------------------------';

		Set @start_time = GetDate();
		Print '>> Truncating Table: [bronze].[erp_cust_az12]';
		Truncate Table [bronze].[erp_cust_az12];
		Print '>> Inserting Data Into: [bronze].[erp_cust_az12]';
		Bulk Insert [bronze].[erp_cust_az12]
		From  'C:\SQL Datawarehouse Project Files\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		With (
			Firstrow = 2,
			Fieldterminator = ',',
			Tablock
		);
			Set @end_time = GetDate();
		Print '>> Load Duration: '+Cast(DateDiff(second, @start_time, @end_time) As Nvarchar) + ' seconds';
		Print '------------------------------------';

		Set @start_time = GetDate();
		Print '>> Truncating Table: [bronze].[erp_loc_a101]';
		Truncate Table [bronze].[erp_loc_a101];
		Print '>> Inserting Data Into: [bronze].[erp_loc_a101]';
		Bulk Insert [bronze].[erp_loc_a101]
		From  'C:\SQL Datawarehouse Project Files\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		With (
			Firstrow = 2,
			Fieldterminator = ',',
			Tablock
		);
			Set @end_time = GetDate();
		Print '>> Load Duration: '+Cast(DateDiff(second, @start_time, @end_time) As Nvarchar) + ' seconds';
		Print '------------------------------------';

		Set @start_time = GetDate();
		Print '>> Truncating Table: [bronze].[erp_px_cat_g1v2]';
		Truncate Table [bronze].[erp_px_cat_g1v2];
		Print '>> Inserting Data Into: [bronze].[erp_px_cat_g1v2]';
		Bulk Insert [bronze].[erp_px_cat_g1v2]
		From  'C:\SQL Datawarehouse Project Files\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		With (
			Firstrow = 2,
			Fieldterminator = ',',
			Tablock
		);
			Set @end_time = GetDate();
		Print '>> Load Duration: '+Cast(DateDiff(second, @start_time, @end_time) As Nvarchar) + ' seconds';
		Print '------------------------------------';

Commit Transaction;
		Set @batch_end_time = GetDate();
		Print '------------------------------------';
		Print 'Loading Bronze Layer is Completed';
		Print '>> Total Load Duration: '+Cast(DateDiff(second, @batch_start_time, @batch_end_time) As Nvarchar) + ' seconds';
		Print '------------------------------------';
	End Try
	Begin Catch
		If @@TRANCOUNT > 0
			Rollback Transaction;
		Print '====================================';
		Print 'Error Occurred During Loading Bronze Layer';
		Print 'Error Message' + Error_Message ();
		Print 'Error Message' + Cast (Error_Number () As Nvarchar);
		Print 'Error Message' + Cast (Error_State () As Nvarchar);
		Print '====================================';
	Throw;
	End Catch
End
