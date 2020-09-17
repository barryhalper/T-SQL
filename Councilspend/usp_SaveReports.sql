USE [CouncilSpend]
GO
/****** Object:  StoredProcedure [dbo].[usp_SaveReports]    Script Date: 16/09/2020 19:49:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_SaveReports]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
   TRUNCATE TABLE dbo.Report
   
	--Top 10 Spend By Service Categories
 --   INSERT INTO Report( Item, Value, ItemID, ReportID)
 --   SELECT TOP 10 C.name, SUM(amount),  C.Categoryid as id, 3  
	--FROM Spend S
	--JOIN SpendServiceType SST ON SST.SpendID = S.SpendID AND S.Amount > 500
	--JOIN ServiceType ST  ON ST.ServiceTypeID = SST.ServiceTypeID
	--JOIN ServiceCategory C ON ST.ServiceCategoryID = C.Categoryid
	--GROUP BY C.Categoryid, C.name 
	--ORDER BY   SUM(amount) DESC
    
   
   -- Top 10 Suppliers
    INSERT INTO Report(Value, Item, ItemID, ReportID)
	SELECT TOP 10 SUM(Amount), C.ParentCompany,  C.ParentCompanyID,1
	FROM Spend S 
	JOIN vw_CompanyParentGroup  C ON S.Supplier =C.Company
	GROUP BY  C.ParentCompanyID, C.ParentCompany
	ORDER BY SUM(Amount) DESC
   
   --Top 10 Spending Councils
    INSERT INTO Report(Value, Item, ItemID, ReportID)
    SELECT   SUM(S.Amount), C.Name, C.CouncilID , 2
    FROM Spend S JOIN SpendDataSet DS ON DS.UID = S.DataSetID JOIN Council C ON DS.CouncilID = C.CouncilID 
    GROUP BY  C.CouncilID, C.Name 
    ORDER BY SUM(S.Amount) DESC 
   
   
   --Top  Spend By Service Categories
    INSERT INTO Report(  Value, ItemID, Item, ReportID)
   SELECT SUM(S.Amount), C.Categoryid, C.name, 4
	FROM  ServiceCategory C
	JOIN ServiceType T ON C.Categoryid = T.ServiceCategoryID 
	JOIN SpendServiceType ST ON T.ServiceTypeID = ST.ServiceTypeID
	JOIN Spend S ON ST.SpendID = S.SpendID AND S.Amount > 500 
	GROUP BY C.Categoryid, C.name
	
	 INSERT INTO Report(  Value, ItemID, Item, ReportID)
	SELECT SUM(S.Amount), T.ServiceTypeID, T.ServiceType, 5
	FROM ServiceType T
	JOIN SpendServiceType ST ON T.ServiceTypeID = ST.ServiceTypeID 
	JOIN Spend S ON ST.SpendID = S.SpendID AND S.Amount > 500 
	GROUP BY T.ServiceTypeID, T.ServiceType
	
	--Top 10 Councils  By Service Categories
	  ;WITH Cte as(
      SELECT *, ROW_NUMBER() OVER (PARTITION BY ServiceCategoryID ORDER BY Total DESC ) as rn
      FROM vw_TotalSpendByCategory
      )
      
      INSERT INTO Report( Item, Value, ItemID, ReportID, GroupID)
      SELECT  Company, Total, ID, 6, ServiceCategoryID
      FROM Cte
      WHERE rn <=10 
	
	--Top 10 Suppliers  By Service Categories
	  ;WITH Cte1 as (
	  SELECT *, ROW_NUMBER() OVER (PARTITION BY ServiceCategoryID ORDER BY Total DESC ) as rn
	  FROM vw_TotalSupplierSpendByCategory WHERE ID IS NOT NULL)
		
	  INSERT INTO Report( Item, Value, ItemID, ReportID, GroupID)
      SELECT  Company, Total, ID, 8, ServiceCategoryID
      FROM Cte1
      WHERE rn <=10 
      
      --Service Totals By category
       INSERT INTO Report( Item, Value, ItemID, ReportID, GroupID)
        SELECT T.ServiceType, SUM(S.Amount), T.ServiceTypeID, 9,  T.ServiceCategoryID 
		FROM ServiceType T
		JOIN SpendServiceType ST ON T.ServiceTypeID = ST.ServiceTypeID 
		JOIN Spend S ON ST.SpendID = S.SpendID AND S.Amount > 500 
		GROUP BY T.ServiceTypeID, T.ServiceType,  T.ServiceCategoryID 
	
END
