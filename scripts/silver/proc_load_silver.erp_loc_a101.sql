/*
-- erp_loc_a101 Silver Layer Data Load Stored Procedure

Script Purpose:
    This script removes the hyphen from the cid in the erp_loc_a101 table so that is may be joined with the crm_cust_info
    table on cst_key. Additionally it cleans up the cntry column by replacing DE with Germany and US/USA with United States
    for consistency and readability in the cntry column.
*/

Insert Into silver.erp_loc_a101 (
    cid,
    cntry
)

Select
    Replace (cid, '-','') As cid,
    Case When Trim(cntry) = 'DE' Then 'Germany'
    When Trim(cntry) In ('US', 'USA') Then 'United States'
    When Trim(cntry) = '' or Trim(cntry) Is Null Then 'n/a'
    Else Trim(cntry)
    End As cntry
From bronze.erp_loc_a101
