CREATE PROCEDURE [dbo].[usp_UpdateCompany_RemoveDupes]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	;
WITH cte
     AS (SELECT ROW_NUMBER() OVER (PARTITION BY Company, ParentCompanyID
                                       ORDER BY ( SELECT 0)) RN
         FROM   Company)
DELETE
FROM cte
WHERE  RN > 1;


DELETE
FROM Company  
WHERE EXISTS(SELECT * FROM Company CP WHERE CP.CompanyID = Company.ParentCompanyID AND CP.Company = Company.Company)


END

GO