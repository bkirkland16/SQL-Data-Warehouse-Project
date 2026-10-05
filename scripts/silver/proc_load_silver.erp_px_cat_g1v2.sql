/*
-- erp_px_cat_g1v2 Silver Layer Data Load Stored Procedure

Script Purpose:
	This script loads the data into the silver layer version of erp_px_cat_g1v2 with out performing any cleansing or
	transforming as none is needed.
*/

Insert Into silver.erp_px_cat_g1v2 (
	id,
	cat,
	subcat,
	maintenance
)

Select 
	id,
	cat,
	subcat,
	maintenance
From bronze.erp_px_cat_g1v2
