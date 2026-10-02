/*
-- crm_cust_info Silver Layer Data Load Stored Procedure

Script Purpose:
	This script transforms the data from bronze.crm_cust_info trimming spaces from cst_firstname and cst_lastname, and
	transforming the data from cst_material_status and cst_gndr into useful and easy to understand term while handling nulls,
	and finally removing duplicates from the cst_id column by ranking the data by cst_create_date to only take the most recent
	line items.
	Lastly the script inserts the data into silver.crm_cust_info.
*/

Insert Into silver.crm_cust_info (
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date)
Select 
	cst_id,
	cst_key,
	Trim(cst_firstname) As cst_firstname,
	Trim(cst_lastname) As cst_lastname,
		Case When Upper(Trim(cst_material_status)) = 'S' Then 'Single'
			When Upper(Trim(cst_material_status)) = 'M' Then 'Married'
			Else 'n/a'
	End As cst_marital_status,
		Case When Upper(Trim(cst_gndr)) = 'F' Then 'Female'
			When Upper(Trim(cst_gndr)) = 'M' Then 'Male'
			Else 'n/a'
		End cst_gndr,
	cst_create_date
From (
Select *,
Row_Number () Over (Partition by cst_id Order By cst_create_date Desc) As flag_last
From [bronze].[crm_cust_info]
)t Where flag_last =1
