-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetStatisticsByParentCompany]
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT 
(    
SELECT COUNT(*) 
FROM rpt_CompanyServiceSpendTotal
WHERE id=  @id 
) as NumRows,

(
SELECT SUM(Total) 
FROM rpt_CompanyServiceSpendTotal 
WHERE id=  @id 
) as TotalSpend,
(
SELECT 
MAX(CAST(CAST([year] AS varchar) + '-' + CAST([month] AS varchar) + '-' + CAST(1 AS varchar) AS DATETIME))
FROM Spend S
JOIN  SpendDataSet DS ON S.DataSetID = DS.UID
JOIN  vw_CompanyParentGroup C ON S.Supplier = C.Company AND C.ParentCompanyID =  @ID
) as lastUpdated


END




GO