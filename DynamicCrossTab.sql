SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


/************************************************\
SP: sp_GetCouncilsStats
Description: return all councils and specific attributes that make up statistics. 
Uses a cursor to create a dynamic cross tab query (whcih in turn is calling a the UDF fn_AttributeCrossTab)

HISTORY:
Date:	    Author:               Description:
2006-07-17  Barry  Halper         Created
\************************************************/


ALTER    PROCEDURE sp_GetCouncilsStats
-- todo: add input variables
-- 
-- (
-- @StatType varchar (50),
-- @CouncilTypeID varchar (50),
-- @CountryID varchar (50)
-- )
-- 
 AS


SET CONCAT_NULL_YIELDS_NULL OFF 


/* SET LOCAL VARS TO BE USED IN CURSOR */
DECLARE 
@AttributeName varchar(50),
@SQLSelect  	varchar(75),
@SQLFrom  	varchar(75),
@SQLCrosstab  	varchar(1500),
@SQL  		varchar(2000)




/*Set SQL 'SELECT' and 'FROM' statments into string vars*/
SET @SQLSELECT = 'SELECT  DISTINCT	O.Organisation, O.OrganisationID '	
SET  @SQLFrom    = ' FROM Organisation O WHERE O.OrganisationTypeID=5'


 /*declare cursor to scroll through Attribute table */
DECLARE varCurs CURSOR FOR
SELECT Attribute
FROM	Attribute
WHERE	AttributeID IN(128,129,130) /*todo: change this to input variable*/

OPEN varCurs

 FETCH varCurs INTO @AttributeName

 --begin loop
 WHILE (@@fetch_status=0)
	
	BEGIN	
		/*create a column in sql stament for each iteration of cursor: each iteration calls udf to prduce cross tab*/ 
		SET @SQLCrosstab = @SQLCrosstab + ', ' +
		'dbo.fn_AttributeCrossTab(O.OrganisationID, ''' + @AttributeName +  ''') AS ' + '[' + @AttributeName + ']'
		
		FETCH varCurs INTO @AttributeName
		
		
	END

/*Concatenate SQl strings into 1 string var*/
SET @SQL = @SQLSELECT + @SQLCrosstab + @SQLFrom
--PRINT (@SQL)
/* execute sql statement*/
EXEC (@SQL)

CLOSE varCurs
DEALLOCATE varCurs





