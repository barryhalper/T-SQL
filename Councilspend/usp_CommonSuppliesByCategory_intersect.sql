CREATE PROC [dbo].[usp_CommonSuppliesByCategory]

AS

SELECT  A.ParentCompanyID 
FROM 
(
 SELECT * FROM
(
SELECT  CP.ParentCompanyID
FROM Council C
JOIN SpendDataSet DS ON C.CouncilID = DS.CouncilID AND DS.CouncilID = 73
JOIN Spend S ON  DS.UID =S.DataSetID
JOIN dbo.vw_CompanyParentGroup CP ON CP.Company = S.Supplier
JOIN  SpendServiceType ST ON S.SpendID = ST.SpendID
 JOIN ServiceType SE ON ST.ServiceTypeID = SE.ServiceTypeID AND SE.ServiceCategoryID = 24

GROUP BY  C.CouncilID, C.name, CP.ParentCompanyID, CP.ParentCompany
)
AS CTE
WHERE EXISTS (SELECT * FROM vw_ParentCompanies P WHERE P.CompanyID = CTE.ParentCompanyID)
	

INTERSECT


 SELECT * FROM
(
SELECT  CP.ParentCompanyID
FROM Council C
JOIN SpendDataSet DS ON C.CouncilID = DS.CouncilID AND DS.CouncilID = 250
JOIN Spend S ON  DS.UID =S.DataSetID
JOIN dbo.vw_CompanyParentGroup CP ON CP.Company = S.Supplier
JOIN  SpendServiceType ST ON S.SpendID = ST.SpendID
 JOIN ServiceType SE ON ST.ServiceTypeID = SE.ServiceTypeID AND SE.ServiceCategoryID = 24

GROUP BY  C.CouncilID, C.name, CP.ParentCompanyID, CP.ParentCompany
)
AS CTE
WHERE EXISTS (SELECT * FROM vw_ParentCompanies P WHERE P.CompanyID = CTE.ParentCompanyID)
 
 ) A
 GROUP BY A.ParentCompanyID










  
GO