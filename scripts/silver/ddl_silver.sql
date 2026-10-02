/*
-- Create Silver Layer Data Tables

Script Purpose:
	This script checks to see if the object exists in the database, if it does it drops the table
	and recreates it with the column names and data types specified below.
Run this script to re-define the DDL structure of "silver" tables.
*/

If Object_ID ('silver.crm_cust_info','U') Is Not Null
	Drop Table silver.crm_cust_info
Create Table silver.crm_cust_info (
	cst_id Int,
	cst_key Nvarchar (50),
	cst_firstname Nvarchar (50),
	cst_lastname Nvarchar (50),
	cst_marital_status Nvarchar (50),
	cst_gndr Nvarchar (50),
	cst_create_date Date,
	dwh_create_date Datetime2 Default GetDate()
);

If Object_ID ('silver.crm_prd_info','U') Is Not Null
	Drop Table silver.crm_prd_info
Create Table silver.crm_prd_info (
	prd_id Int,
	cat_id Nvarchar (50),
	prd_key Nvarchar (50),
	prd_nm Nvarchar (50),
	prd_cost Int,
	prd_line Nvarchar (50),
	prd_start_dt Date,
	prd_end_dt Date,
	dwh_create_date Datetime2 Default GetDate()
);

If Object_ID ('silver.crm_sales_details','U') Is Not Null
	Drop Table silver.crm_sales_details
Create Table silver.crm_sales_details (
	sls_ord_num Nvarchar (50),
	sls_prd_key Nvarchar (50),
	sls_cust_id Int,
	sls_order_dt Date,
	sls_ship_dt Date,
	sls_due_dt Date,
	sls_sales Int,
	sls_quantity Int,
	sls_price Int,
	dwh_create_date Datetime2 Default GetDate()
);

If Object_ID ('silver.erp_loc_a101','U') Is Not Null
	Drop Table silver.erp_loc_a101
Create Table silver.erp_loc_a101 (
	cid Nvarchar (50),
	cntry Nvarchar (50),
	dwh_create_date Datetime2 Default GetDate()
);

If Object_ID ('silver.erp_cust_az12','U') Is Not Null
	Drop Table silver.erp_cust_az12
Create Table silver.erp_cust_az12 (
	cid Nvarchar (50),
	bdate Date,
	gen Nvarchar (50),
	dwh_create_date Datetime2 Default GetDate()
);

If Object_ID ('silver.erp_px_cat_g1v2','U') Is Not Null
	Drop Table silver.erp_px_cat_g1v2
Create Table silver.erp_px_cat_g1v2 (
	id Nvarchar (50),
	cat Nvarchar (50),
	subcat Nvarchar (50),
	maintenance Nvarchar (50),
	dwh_create_date Datetime2 Default GetDate()
);
