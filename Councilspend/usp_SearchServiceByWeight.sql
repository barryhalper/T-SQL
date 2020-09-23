CREATE  PROC [dbo].[usp_SearchServiceByWeight]
(	
	-- Add the parameters for the function here
	@str varchar(500),
	@sql varchar(4000) OUT/*return sql string to be executed*/
)

AS
	BEGIN
	
	
	DECLARE  @weight_value float, @weight_term varchar(150),
	@sqlIsABout varchar(4000),
	@pos int

	
	
	SET @sqlIsABout	='''IsAbout('
		
		DECLARE cursor_weight CURSOR STATIC FOR
		
		SELECT W.[weight], [Term] 
		FROM dbo.fn_ConvertToTable_Vars(@str, ' ') FN
		JOIN [dbo].[SearchTermWeight] W ON W.Term = FN.Value
		
		SET @pos = 1/* will be inccremenent in cursor*/

		OPEN cursor_weight

		FETCH NEXT FROM cursor_weight INTO @weight_value , @weight_term	
		WHILE @@FETCH_STATUS = 0   

		BEGIN
						
						/**build 'IsAbout' terms using datatset*/
						SET @sqlIsABout = @sqlIsABout  +  + @weight_term + ' WEIGHT (' + CONVERT(varchar(5), @weight_value) + ') '
						/*check If Loop position is not the last then add remain comma*/
						IF @pos <  @@CURSOR_ROWS
							SET @sqlIsABout = @sqlIsABout + ','
						
						/*increment row position 	*/
						SET @pos = @pos + 1
						FETCH NEXT FROM cursor_weight INTO @weight_value , @weight_term	

END



CLOSE cursor_weight   
DEALLOCATE cursor_weight

IF(@sqlIsABout = '')


/*SET STRING SQL TO BE RETURNED*/
SET @SQL = ' SELECT S.ServiceTypeID
FROM ServiceType S
JOIN CONTAINSTABLE(ServiceType, *, '+@sqlIsABout +')''
 ) AS K
ON K.[Key] = S.ServiceTypeID
ORDER BY K.Rank DESC'

ELSE 
/*IF no records found return null*/
 
 SET @SQL = NULL

END



GO