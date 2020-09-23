CREATE PROCEDURE [dbo].[usp_UpdateColumnNameInTemp]
	-- Add the parameters for the stored procedure here
	@tableName varchar(100),
	@councilid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @name varchar(255), @NewName varchar(255), @SQL varchar(4000)


		DECLARE curs CURSOR STATIC FOR
		SELECT COLUMN_NAME
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = @tableName
		
		OPEN curs   
		
			 FETCH NEXT FROM curs INTO  @name
				WHILE @@FETCH_STATUS = 0   
				BEGIN 
			
				
				
			 	SET @NewName  = ( SELECT TOP 1 S.ColumnName 
						FROM ColumnDataSet C
						JOIN SpendColumn S ON C.SpendColumnID = S.ColumnID
						WHERE OrganisationID = @councilid
						AND C.DataColumn = @name)
			--SELECT @NewName, @name
				
				SET @SQL = 'EXEC sp_RENAME ''dbo.'+@tableName+'.['+ @name +']''' + ', ''' + @NewName + ''',' + '''COLUMN'''
				
				--PRINT @SQL
				EXEC  (@SQL)
							
				FETCH NEXT FROM curs INTO @name
			END
			CLOSE curs   
			DEALLOCATE curs
END
