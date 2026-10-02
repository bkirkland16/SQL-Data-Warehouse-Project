/*
-- crm_prd_info Silver Layer Data Load Stored Procedure

Script Purpose:
	This script cleans and transforms the data from bronze.crm_prd_info by breaking apart the prd_key into cat_id
	and prd_key for joining. cat_id maps to id from erp_px_cat_gv12 and prd_key maps to sls_prd_key from crm_sales_details.
	Cleans up prd_cost by transforming Null values into zeroes, transmforms the single letters in prd_line into more friendly
	easy to understand words, and cleans up "prd_start_dt"s and "prd_end_dt"s by making sure no prd_end_dt is before it's
	relevant prd_start_dt by recreating the prd_end_dt as one day before the products next prd_start_dt.
*/

Insert Into [silver].[crm_prd_info] (
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
Select
	prd_id,
	Replace(Substring (prd_key, 1, 5), '-','_') As cat_id,
	Substring (prd_key, 7, Len(prd_key)) As prd_key,
	prd_nm,
	IsNull(prd_cost, 0) As prd_cost,
	Case Upper(Trim(prd_line))
		When  'M' Then 'Mountain'
		When  'R' Then 'Road'
		When  'S' Then 'Other Sales'
		When  'T' Then 'Touring'
		Else 'n/a'
		End As prd_line,
	Cast(prd_start_dt As Date) As prd_start_dt,
	Cast(Lead(prd_start_dt) Over (Partition By prd_key Order By prd_start_dt)-1 As Date) As prd_end_dt
From bronze.crm_prd_info
