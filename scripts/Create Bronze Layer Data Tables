/*
-- Create Bronze Layer Data Tables

Script Purpose:
	This script checks to see if the object exists in the database, if it does it drops the table
	and recreates it with the column names and data types specified below.
Run this script to re-define the DDL structure of "bronze" tables.
*/

If Object_ID ('bronze.crm_cust_info','U') Is Not Null
	Drop Table bronze.crm_cust_info
Create Table bronze.crm_cust_info (
	cst_id Int,
	cst_key Nvarchar (50),
	cst_firstname Nvarchar (50),
	cst_lastname Nvarchar (50),
	cst_marital_status Nvarchar (50),
	cst_gndr Nvarchar (50),
	cst_create_date Date
);

If Object_ID ('bronze.crm_prd_info','U') Is Not Null
	Drop Table bronze.crm_prd_info
Create Table bronze.crm_prd_info (
	prd_id Int,
	prd_key Nvarchar (50),
	prd_nm Nvarchar (50),
	prd_cost Int,
	prd_line Nvarchar (50),
	prd_start_dt Datetime,
	prd_end_dt Datetime
);

If Object_ID ('bronze.crm_sales_details','U') Is Not Null
	Drop Table bronze.crm_sales_details
Create Table bronze.crm_sales_details (
	sls_ord_num Nvarchar (50),
	sls_prd_key Nvarchar (50),
	sls_cust_id Int,
	sls_order_dt Int,
	sls_ship_dt Int,
	sls_due_dt Int,
	sls_sales Int,
	sls_quantity Int,
	sls_price Int
);

If Object_ID ('bronze.erp_loc_a101','U') Is Not Null
	Drop Table bronze.erp_loc_a101
Create Table bronze.erp_loc_a101 (
	cid Nvarchar (50),
	cntry Nvarchar (50)
);

If Object_ID ('bronze.erp_cust_az12','U') Is Not Null
	Drop Table bronze.erp_cust_az12
Create Table bronze.erp_cust_az12 (
	cid Nvarchar (50),
	bdate Date,
	gen Nvarchar (50)
);

If Object_ID ('bronze.erp_px_cat_g1v2','U') Is Not Null
	Drop Table bronze.erp_px_cat_g1v2
Create Table bronze.erp_px_cat_g1v2 (
	id Nvarchar (50),
	cat Nvarchar (50),
	subcat Nvarchar (50),
	maintenance Nvarchar (50)
);
