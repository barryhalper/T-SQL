-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_matchServiceAlgorithim]
	-- Add the parameters for the stored procedure here
	@resultCount INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

     --CREATE ALL TEMP TABLES FOR LATER US
	DECLARE @tableCur TableCurs  
	DECLARE @ID int,  @ServiceSpecific varchar(500), @serviceid int, @estimatedService varchar(1500), @str varchar(150), @NumServices int, 
	@strSyn varchar(150), @categoryid int, @TopCategoryid int
    
     
	IF object_id('tempdb..#tempSearch')  IS NOT NULL  DROP TABLE #tempSearch
				CREATE TABLE #tempSearch
				(ID int,
				 Serviceid int
				
			)
			--ADD INDEXES FOR PERFORMANCE
			CREATE NONCLUSTERED INDEX NIXS_ID
			ON #tempSearch(ID)
			
			CREATE NONCLUSTERED INDEX NIXS_Serviceid
			ON #tempSearch(Serviceid)
			
	IF object_id('tempdb..#tempSearchCount') IS NOT NULL  DROP TABLE #tempSearchCount
				CREATE TABLE #tempSearchCount
				(ID int,
				 NumRows int,
			)
			
			CREATE NONCLUSTERED INDEX NIXC_ID
			ON #tempSearchCount(ID)
			
			CREATE NONCLUSTERED INDEX NIXC_NumRows
			ON #tempSearchCount(NumRows)
			
		IF object_id('tempdb..#tempService') IS NOT NULL DROP TABLE #tempService
				CREATE TABLE #tempService
				(ID int,
				 ServiceID int,
			)
		
			CREATE NONCLUSTERED INDEX NIXE_ID
			ON #tempService(ID)
			
			CREATE NONCLUSTERED INDEX NIXE_Serviceid
			ON #tempService(Serviceid)
		
	
		
		/* GET ALL UNMAPPED DATA FOR TEMP TABLE TO CURSOR OVER (faster than cursing over raw qry)*/
		INSERT INTO @tableCur(ID, ServiceSpecific)
		SELECT DISTINCT SF.ID, SF.ServiceSpecific
		FROM ServiceFromAccess SF
		JOIN Spend S ON S.Service = SF.ServiceSpecific 
		WHERE SF.ServiceID IS NULL
		AND  NOT EXISTS (SELECT * FROM SpendServiceType ST WHERE S.SpendID =ST.SpendID)
	
		
			INSERT INTO #tempSearch(ID, ServiceID)
			SELECT ID, ServiceID 
			FROM dbo.fn_FTSinService(@tableCur)
	
			INSERT INTO #tempSearchCount(ID, NumRows)
			SELECT ID, COUNT(*) 
			FROM #tempSearch
			GROUP BY ID
			
			--INSERT RESULTS THAT HAVE ONLY 1 MATCH
			INSERT INTO #tempService(ID, ServiceID)
			SELECT S.ID, S.Serviceid
			FROM #tempSearchCount C
			JOIN #tempSearch  S ON C.ID = S.ID
			WHERE NumRows = 1
			
			
			--LOOP OVER RESULTS THAT HAVE MORE THAN ONE MATCH
			
			DECLARE db_cursorCat CURSOR STATIC FOR
			
			SELECT S.ID, SF.ServiceSpecific, S.Serviceid
			FROM #tempSearchCount C
			JOIN #tempSearch  S ON C.ID = S.ID
			JOIN ServiceFromAccess SF ON SF.ID = S.ID
			WHERE NumRows > 1
		
		
			OPEN db_cursorCat   
		
			 FETCH NEXT FROM db_cursorCat INTO @ID , @ServiceSpecific, @serviceid
				WHILE @@FETCH_STATUS = 0   
				BEGIN 
			
				FETCH NEXT FROM db_cursorCat INTO @ID , @ServiceSpecific, @serviceid
							-- FIND CATEGORY THAT MATCHES ORIGINAL SERCH TERM & FOUND SERVICES
							SET @TopCategoryid = (
								SELECT TOP 1 Categoryid 
								FROM ServiceCategory C
								JOIN ServiceType S ON S.ServiceCategoryID = C.Categoryid
								JOIN #tempSearch T ON T.Serviceid = S.ServiceTypeID AND T.ID = @ID								
								WHERE FREETEXT (name,   @ServiceSpecific))
								
							IF (@TopCategoryid IS NOT NULL)
								INSERT INTO #tempService(ID, ServiceID)
								SELECT TOP 1 @ID, ServiceID
								FROM  #tempSearch T
								JOIN ServiceType SC ON T.Serviceid = SC.ServiceTypeID AND SC.ServiceCategoryID =@TopCategoryid
								WHERE ID = @ID  
								
							ELSE 
							INSERT INTO #tempService(ID, ServiceID)
								SELECT TOP 1 @ID, ServiceID
								FROM  #tempSearch T
								WHERE ID = @ID  
							
					
					SET @TopCategoryid = NULL
				END
				CLOSE db_cursorCat   
				DEALLOCATE db_cursorCat
			
				/* INSERT FINAL DATA INTO LIVE JOIN DATA */
				INSERT INTO dbo.SpendServiceType(SpendID, ServiceTypeID)
				SELECT SP.SpendID, T.ServiceID 
				FROM  #tempService T
				JOIN ServiceFromAccess S ON S.ID = T.ID
				JOIN Spend SP ON SP.[Service] = S.ServiceSpecific
				WHERE NOT EXISTS (SELECT * FROM  dbo.SpendServiceType  SS WHERE SS.SpendID = SP.SpendID)
				
		
				
	
				DROP TABLE #tempSearch
				DROP TABLE #tempSearchCount
				DROP TABLE  #tempService
	
END

GO