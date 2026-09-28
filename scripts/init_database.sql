/*
-- Create Database 'DataWarehouse'

Script Purpose:
	This script creates a new database name 'DataWarehouse' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
	within the database: 'bronze', 'silver', and 'gold'.

Warning:
	Running this script will drop the entire 'Datawarehouse' database if it exists.
	All data in the database will be permanently deleted. Proceed with caution
	and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
If Exists (Select 1 From sys.databases Where name = 'DataWarehouse')
Begin
	Alter Database DataWarehouse Set Single_User With Rollback Immediate;
	Drop Database DataWarehouse;
End;
Go

-- Create the 'DataWarehouse' database
Create Database DataWarehouse;
Go

Use DataWarehouse;
Go

--Create Schemas
Create Schema bronze;
Go

Create Schema silver;
Go

Create Schema gold;
Go
