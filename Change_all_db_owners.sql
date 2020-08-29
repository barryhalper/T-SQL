DECLARE @currentObject nvarchar(517)
DECLARE @qualifiedObject nvarchar(517)
DECLARE @currentOwner varchar(50)
DECLARE @newOwner varchar(50)

SET @currentOwner = 'coldfusion'
SET @newOwner = 'dbo'

DECLARE alterOwnerCursor CURSOR FOR
SELECT [name] FROM dbo.sysobjects 
WHERE xtype = 'U' or xtype = 'P'
AND LEFT([name], 2) <> 'dt' AND Uid = 7 

OPEN alterOwnerCursor

FETCH NEXT FROM alterOwnerCursor INTO @currentObject
WHILE @@FETCH_STATUS = 0
	BEGIN
   	SET @qualifiedObject = CAST(@currentOwner as varchar) + '.' + CAST(@currentObject as varchar)
   	EXEC sp_changeobjectowner @qualifiedObject, @newOwner
   	FETCH NEXT FROM alterOwnerCursor INTO @currentObject

END
CLOSE alterOwnerCursor
DEALLOCATE alterOwnerCursor