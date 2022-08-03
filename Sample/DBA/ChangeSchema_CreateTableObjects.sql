--==================
-- Hack Script :)
-- Selecting schema objects into a new table from another
--==================

DECLARE @oldSchema NVARCHAR(20) 
DECLARE @newSchema NVARCHAR(20) 
DECLARE @someTable NVARCHAR(20)

Set @oldSchema = 'SomeSchema'
Set @newSchema = 'SomeOtherSchema'
Set @someTable = 'someTable'

DECLARE @Sql NVARCHAR(max)


-- Hacks Lol .... Must Be ran in SSMS...Fun Stuff
-- Select all data into a new table very valuable when changing usernames
Select *
Into newtable
From Importing.ALDI_3PW
Where 1 = 0;
GO

-- I have an ETL database that I use with customer C# scripts for injestion and other data transformations
Rename Object
Exec sp_rename 'ELTStaging', 'ALDIStaging'
Go

-- Change Schema Name
 Select @Sql = 'Alter Schema [' + @newSchema + ']
                Transfer [' + @oldSchema + '].[' + @someTable + ']';
EXEC(@Sql)
Go

