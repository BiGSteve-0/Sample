--=============================================
-- Rebuilding all indexes in a schema
-- Created by Steven Harris
-- Created on 6/10/22
--==========================================


DECLARE @TableName varchar(255)
DECLARE TableCursor CURSOR FOR
SELECT table_name FROM information_schema.tables
WHERE table_type = 'base table'

OPEN TableCursor
FETCH NEXT FROM TableCursor INTO @TableName
WHILE @@FETCH_STATUS = 0
BEGIN
  -- change print to execute all the same and this works for tables in a schema except Edi because the 204Config table starts with a number
  print('ALTER INDEX ALL ON ' + @TableName + ' REBUILD') -- can aslo use reorganize
  FETCH NEXT FROM TableCursor INTO @TableName
END
CLOSE TableCursor
DEALLOCATE TableCursor;
Go