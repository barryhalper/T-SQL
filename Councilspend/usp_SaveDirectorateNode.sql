CREATE PROCEDURE [dbo].[usp_SaveDirectorateNode]
	-- Add the parameters for the stored procedure here
	@node varchar(200),
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	   SET @node = RTRIM(LTRIM(@node))
	   --convert id to string to use in string SQL
	   DECLARE @strID varchar(6) =  CONVERT(varchar(6), @id)
	  
	   DECLARE @where VARCHAR(300) = ''
	   DECLARE @WhereIn VARCHAR(300) = ''
		
		-- create dynamic where clauses for search
		SELECT @where = COALESCE(@where + ' AND (directorate LIKE ''%', '') + rtrim(ltrim(value)) + '%'' ) ',
			       @WhereIn = COALESCE(@WhereIn + ',''', '') + rtrim(ltrim(value)) +'''' 
		FROM   dbo.fn_ConvertToTable_Vars(rtrim(ltrim(@node)), ' ')
		
		--remove first delimiter from coalescion
		SET	@WhereIn = SUBSTRING (@WhereIn, 2, LEN(@WhereIn))
		
		
		IF @node = 'IT'
			SET @where = 'AND directorate LIKE ''% IT %'''
		

		DECLARE @SQL varchar(4000)
		SET @SQL = 'INSERT INTO dbo.TaxonomyNodeDirectorate(NodeID, Directorate)
						  SELECT DISTINCT ' + @strID +', S.Directorate 
						  FROM Spend S 
						  WHERE 0=0 ' +  @where +
						  ' AND  (NOT EXISTS (SELECT * FROM dbo.TaxonomyNodeDirectorate NS WHERE NS.Directorate IN (' + @WhereIn +') AND NS.NodeID = '+@strID+'))' 
		
		EXEC (@SQL)		
	  

		

	END


GO
