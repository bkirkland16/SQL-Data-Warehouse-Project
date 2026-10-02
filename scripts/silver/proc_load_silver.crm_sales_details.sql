/*
-- crm_sales_details Silver Layer Data Load Stored Procedure

Script Purpose:
	This script cleans and transforms the data from bronze.crm_sales_details by setting invalid sls_order_dt,
	sls_ship_dt, and sls_due_dt dates to Null. A date is invalid if it lacks enough data to constitute a valid date,
	in this case a length of 8 characters or if the value is zero. Additionally the script cleans up sls_sales by
	multiplying sls_quantity by the absolute value of sls_price if sls_sales is zero, negative, null, or not equal to
	sls_quantity multiplied by the absolute value of sls_price. Finally it cleans up sls_price by dividing sls_sales by
	sls_quantity if sls_price is zero, negative, or null. If there is a zero in sls_quantity the case statement for sls_price
	has a NullIf to catch it and replace it with a null to avoid trying to divide by zero.
*/

Insert Into silver.crm_sales_details (
	sls_ord_num,
	sls_prd_key,
	Sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)

SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
Case When sls_order_dt = 0 Or Len(sls_order_dt) !=8 Then Null
	Else Cast(Cast(sls_order_dt As Varchar) As Date)
	End As sls_order_dt,
Case When sls_ship_dt = 0 Or Len(sls_ship_dt) !=8 Then Null
	Else Cast(Cast(sls_ship_dt As Varchar) As Date)
	End As sls_ship_dt,
Case When sls_due_dt = 0 Or Len(sls_due_dt) !=8 Then Null
	Else Cast(Cast(sls_due_dt As Varchar) As Date)
	End As sls_due_dt,
Case When sls_sales <=0 Or sls_sales != sls_quantity * ABS(sls_price) Or sls_sales Is Null Then sls_quantity * ABS(sls_price)
		Else sls_sales
		End As sls_sales,
sls_quantity,
Case When sls_price <= 0 Or sls_price Is Null Then sls_sales / NullIf(sls_quantity, 0)
		Else sls_price
		End As sls_price
FROM bronze.crm_sales_details
