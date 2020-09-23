-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ServiceAlgorithm]
	-- Add the parameters for the stored procedure here
	--@startRow int = 0,
	--@endRow int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

DECLARE @Table table (ID INT, ServiceID INT)
DECLARE @ID int,  @ServiceSpecific varchar(500), @serviceid int,  @categoryid int, @TopCategoryid int, @NumResults int,
 @ServiceName varchar(500)



DECLARE db_cursorCat CURSOR STATIC FOR


--WITH CTEResults AS
--(
--    SELECT DISTINCT SF.ID, SF.ServiceSpecific,  ROW_NUMBER() OVER (ORDER BY SpendID) AS RowNum
--    FROM ServiceFromAccess SF
--    JOIN Spend S ON S.Service = SF.ServiceSpecific 
	
--	WHERE SF.ServiceID IS NULL
--	AND  NOT EXISTS (SELECT * FROM SpendServiceType ST WHERE S.SpendID =ST.SpendID) 
    
--)

--SELECT ID, ServiceSpecific 
--FROM CTEResults
--WHERE RowNum BETWEEN @startRow AND @endRow

	SELECT DISTINCT SF.ID, SF.ServiceSpecific
    FROM ServiceFromAccess SF
    JOIN Spend S ON S.Service = SF.ServiceSpecific 
	WHERE SF.ServiceID IS NULL
	AND  NOT EXISTS (SELECT * FROM SpendServiceType ST WHERE S.SpendID =ST.SpendID) 

OPEN db_cursorCat   
		
			 FETCH NEXT FROM db_cursorCat INTO @ID , @ServiceSpecific
				WHILE @@FETCH_STATUS = 0   
				BEGIN 
					SET @ServiceName 	= @ServiceSpecific
					SET @ServiceSpecific = ISNULL(dbo.RegExReplace( @ServiceSpecific,  '[^A-Za-z ,]+', ' '), '')
					IF @ServiceSpecific != ''
					
					
					
					
					
						INSERT INTO @Table(ID, ServiceID)
						SELECT @ID, S.ServiceTypeID
							FROM ServiceType S
							WHERE  FREETEXT (  ServiceType,   
									@ServiceSpecific
							   ) 	
							   
						SET @NumResults =	   (SELECT COUNT(*) FROM @Table)
						IF (@NumResults =  1)
							BEGIN
							SET @serviceid = (SELECT TOP 1 ServiceID FROM  @Table) 
							--
							INSERT INTO dbo.SpendServiceType(SpendID, ServiceTypeID)
							SELECT S.SpendID, @serviceid
							FROM Spend S
							WHERE Service = @ServiceName
							AND NOT EXISTS (SELECT * FROM dbo.SpendServiceType ST 	WHERE ST.SpendID=S.SpendID AND ST.ServiceTypeID =@serviceid)
							
							END 
							
						ELSE IF(@NumResults > 1)
							BEGIN
								
									SET @TopCategoryid = (
											SELECT TOP 1 Categoryid 
											FROM ServiceCategory C
											JOIN ServiceType S ON S.ServiceCategoryID = C.Categoryid
											JOIN @Table T ON T.Serviceid = S.ServiceTypeID AND T.ID = @ID								
											WHERE FREETEXT (name,   @ServiceSpecific)
											GROUP BY  Categoryid,  C.priority
											ORDER BY  COUNT(Categoryid) DESC, C.priority DESC)
											
										IF (@TopCategoryid IS NOT NULL)
											BEGIN
											--INSERT INTO dbo.SpendServiceType(SpendID, ServiceTypeID)
											--SELECT TOP 1 @ID, ServiceID
											--FROM  @Table T
											--JOIN ServiceType SC ON T.Serviceid = SC.ServiceTypeID AND SC.ServiceCategoryID =@TopCategoryid
											--WHERE ID = @ID  AND NOT EXISTS (SELECT * FROM dbo.SpendServiceType ST 
											--					WHERE ST.SpendID=T.ID AND ST.ServiceTypeID = T.ServiceID) 		
											SET @serviceid = (SELECT TOP 1 ST.ServiceTypeID 
											FROM ServiceType ST
											JOIN @Table T ON ST.ServiceTypeID = T.ServiceID 
											AND ServiceCategoryID = @TopCategoryid )
											
											INSERT INTO dbo.SpendServiceType(SpendID, ServiceTypeID)
											SELECT S.SpendID, @serviceid
											FROM Spend S
											WHERE Service = @ServiceName
											AND NOT EXISTS (SELECT * FROM dbo.SpendServiceType ST 	WHERE ST.SpendID=S.SpendID AND ST.ServiceTypeID =@serviceid)
											
											END
							
										
										ELSE
											INSERT INTO dbo.SpendServiceType(SpendID, ServiceTypeID)
											SELECT S.SpendID,  (SELECT TOP 1 ServiceID FROM  @Table) 
											FROM Spend S
											WHERE Service = @ServiceName
											AND NOT EXISTS (SELECT * FROM dbo.SpendServiceType ST 	WHERE ST.SpendID=S.SpendID AND ST.ServiceTypeID =@serviceid)
										
							
							END
						 
						DELETE FROM @Table
					
				FETCH NEXT FROM db_cursorCat INTO @ID , @ServiceSpecific
				
			END
				CLOSE db_cursorCat   
				DEALLOCATE db_cursorCat
				
			
			--INSERT SERVIES BY COMPANIES
			INSERT INTO dbo.SpendServiceType(SpendID,ServiceTypeID)
			SELECT  * 
				FROM(
				
				 
				SELECT  DISTINCT
				
				S.SpendID,
						(SELECT  TOP 1 ST.ServiceTypeID
						FROM dbo.fn_Companies(S.Supplier) C
						JOIN Spend S ON S.Supplier = C.company
						JOIN SpendServiceType ST ON S.SpendID = ST.SpendID
						GROUP BY ST.ServiceTypeID
						ORDER BY COUNT(S.SpendID) DESC) as ServiceID
				
				
				FROM ServiceFromAccess SF
				JOIN Spend S ON S.Service = SF.ServiceSpecific AND SF.ServiceID IS  NULL
				JOIN Company C ON C.Company = S.Supplier  AND ((ParentCompanyID IS NOT NULL) OR ( ParentCompanyID IS NOT NULL AND  EXISTS(SELECT * FROM Company P WHERE ParentCompanyID = C.CompanyID)))
				WHERE  NOT EXISTS (SELECT * FROM SpendServiceType ST WHERE S.SpendID =ST.SpendID)
				) AS A
				--ORDER BY S.Supplier
				WHERE A.ServiceID IS NOT NULL

END

GO