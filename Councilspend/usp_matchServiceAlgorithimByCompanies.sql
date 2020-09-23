CREATE PROCEDURE [dbo].[usp_matchServiceAlgorithimByCompanies]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN

DECLARE @TopCategoryid int, @Supplier varchar(200), @id int, @serviceID int, @service varchar(500) 

	IF object_id('tempdb..#tempSearch')  IS NOT NULL  DROP TABLE #tempSearch
				CREATE TABLE #tempSearch
				(--ID INT IDENTITY(1, 1) primary key ,
				 Supplier varchar(150),
				 serviceSpecified varchar(500),
				 serviceID int
			)
			
INSERT INTO #tempSearch(Supplier, serviceSpecified)
SELECT DISTINCT
		S.Supplier,S.Service
		 
		FROM ServiceFromAccess SF
		JOIN Spend S ON S.Service = SF.ServiceSpecific AND SF.ServiceID IS  NULL
		WHERE 
		 NOT EXISTS (SELECT * FROM SpendServiceType ST WHERE S.SpendID =ST.SpendID)
		AND S.Supplier != '' AND S.Amount > 500 
	



		DECLARE curs CURSOR STATIC FOR
		SELECT DISTINCT Supplier, serviceSpecified FROM #tempSearch
		
			OPEN curs   
		
			 FETCH NEXT FROM curs INTO  @Supplier, @service
				WHILE @@FETCH_STATUS = 0   
				BEGIN 
			
				FETCH NEXT FROM curs INTO @Supplier, @service
						
						SET @ServiceID = (SELECT Top 1 ST.ServiceTypeid
						FROM Spend S
						JOIN   SpendServiceType ST ON S.SpendID = ST.SpendID AND  Supplier = @Supplier	
						GROUP BY ST.ServiceTypeid
						ORDER BY COUNT(ST.ServiceTypeid) DESC)
	
	

						-- Return the result of the function
						IF @ServiceID IS NULL AND EXISTS (SELECT * FROM vw_CompanyParentGroup WHERE Company = @Supplier)
						
							SET @ServiceID =(SELECT TOP 1 ST.ServiceTypeID
							FROM Spend S
							JOIN SpendServiceType ST ON S.SpendID = ST.SpendID
							WHERE EXISTS (SELECT * FROM vw_CompanyParentGroup  C  
													WHERE  S.Supplier = C.Company AND Company = @Supplier )
							AND S.Amount > 500
							GROUP BY ST.ServiceTypeID
							ORDER BY COUNT(S.SpendID) DESC)
							
						--	UPDATE #tempSearch
						--	SET serviceID = @serviceID
						--	WHERE id =@id
						IF @ServiceID IS NOT NULL
						INSERT INTO SpendServiceType(SpendID, ServiceTypeID)
						SELECT  S.SpendID, @ServiceID
						FROM Spend S
						WHERE service = @service AND Supplier = @Supplier
						AND NOT EXISTS (SELECT * FROM SpendServiceType ST WHERE ST.SpendID = S.SpendID)
						
						
						 

				END
		CLOSE curs   
		DEALLOCATE curs


		 DROP TABLE #tempSearch



	END
	
	
	
		
		
		
		
		
GO
