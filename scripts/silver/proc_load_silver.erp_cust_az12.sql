/*
-- erp_cust_az12 Silver Layer Data Load Stored Procedure

Script Purpose:
    This script cleans up cid, bdate, and gen using the following transformations. For cid the "NAS" at the beginning of
    the id is removed so that is can be joined with siler.crm_cust_info on the cst_key from that table. bdate is cleaned
    by replacing any recorded bdate with null if that bdate exists in the future. Lastly gen is made more user friendly
    by changing F and M to Female and Male respectively while accounting for any potential case differences in the data,
    also and blanks or Nulls are converted to "n/a" as that is more user friendly.
*/

Insert Into silver.erp_cust_az12 (
    cid,
    bdate,
    gen
)
  
Select
    Case When cid Like 'NAS%' Then Substring (cid,4, Len(cid))
        Else cid
    End cid,
    Case When bdate > GetDate() Then Null
        Else bdate
    End bdate,
    Case When Upper(Trim(gen)) In ('F', 'FEMALE') Then 'Female'
        When Upper(Trim(gen)) In ('M', 'MALE') Then 'Male'
        When Upper(Trim(gen)) Is Null Or Upper(Trim(gen)) = '' Then 'n/a'
        Else gen
    End As gen
From bronze.erp_cust_az12
