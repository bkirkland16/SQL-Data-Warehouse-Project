/*
-- crm_cust_info Data Quality Tests
*/

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

Select cst_id, Count(*)
From silver.crm_cust_info
Group By cst_id
Having Count(*) > 1 Or cst_id Is Null

-- Check for Unwanted Spaces
-- Expectation: No Result

Select cst_firstname
From silver.crm_cust_info
Where cst_firstname != Trim(cst_firstname)

Select cst_lastname
From silver.crm_cust_info
Where cst_lastname != Trim(cst_lastname)

Select cst_marital_status
From silver.crm_cust_info
Where cst_marital_status != Trim(cst_marital_status)

Select cst_gndr
From silver.crm_cust_info
Where cst_gndr != Trim(cst_gndr)

-- Data Standardization & Consistency
-- Expectation: Only Standardized Values Should be Present

Select Distinct cst_marital_status
From silver.crm_cust_info

Select Distinct cst_gndr
From silver.crm_cust_info

/*
-- crm_prd_info Data Quality Tests
*/

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result

Select prd_id, Count(*)
From silver.crm_prd_info
Group By prd_id
Having Count(*) > 1 Or prd_id Is Null

-- Check for Unwanted Spaces
-- Expectation: No Result

Select prd_nm
From silver.crm_prd_info
Where prd_nm != Trim(prd_nm)

Select prd_line
From silver.crm_prd_info
Where prd_line != Trim(prd_line)

--Check for Nulls or Negative Numbers
-- Expectation: No Results

Select prd_cost
From silver.crm_prd_info
Where prd_cost < 0 Or prd_cost Is Null

-- Data Standardization & Consistency
-- Expectation: Only Standardized Values Should be Present

Select Distinct prd_nm
From silver.crm_prd_info

Select Distinct prd_line
From silver.crm_prd_info

-- Check for Invalid Date Orders
-- Expectation: No prd_end_dt before relevant prd_start_date

Select *
From silver.crm_prd_info
Where prd_end_dt < prd_start_dt

/*
-- crm_sales_details Data Quality Tests
*/

-- Check for Invalid Dates
-- Expectation: No Negatives or Zeroes for Dates, and no Illogical Dates

Select sls_order_dt
From silver.crm_sales_details
Where sls_order_dt <= '1900-01-01' Or sls_order_dt >= '2050-01-01'

-- Check for Invalid Date Orders
-- Expectation no sls-order_dt greater than sls_ship_dt and no sls_order_dt greater than sls_due_dt

Select *
From silver.crm_sales_details
Where sls_order_dt > sls_ship_dt Or sls_order_dt > sls_due_dt

-- Check Data Consistency: Between Sales, Quantity, and Price
-- >> Sales = Quantity * Price
-- >> Values must not be Null, zero, or negative
-- Expectation: No Results

Select
	sls_sales,
	sls_quantity,
	sls_price
From silver.crm_sales_details
Where sls_sales != sls_quantity * sls_price
Or sls_sales Is Null Or sls_quantity Is Null Or sls_price Is Null
Or sls_sales <= 0 Or sls_quantity <= 0 Or sls_price <= 0
Order By sls_sales, sls_quantity, sls_price

/*
-- erp_cust_az12 Data Quality Tests
*/

-- Identify Out of Range Dates
-- Expectation: No bdate that is greater than GetDate()

Select Distinct bdate
From silver.erp_cust_az12
Where bdate > GetDate()

-- Data Standardization & Consistency
-- Expectation: Only Standardized Values Should be Present

Select Distinct gen
From silver.erp_cust_az12

/*
-- erp_loc_a101 Data Quality Tests
*/

-- Data Standardization & Consistency
-- Expectation: Only Standardized Values Should be Present

Select Distinct cntry
From silver.erp_loc_a101

/*
-- erp_px_cat_g1v2 Data Quality Tests
*/

-- Check for Unwanted Spaces
-- Expectation: No Results

Select *
From silver.erp_px_cat_g1v2
Where cat != Trim(cat) Or subcat != Trim(subcat) Or maintenance != Trim(maintenance)

-- Data Standardization & Consistency
-- Expectation: Only Standardized Values Should be Present

Select Distinct maintenance
From silver.erp_px_cat_g1v2
