CREATE PROCEDURE [dbo].[usp_getCompanyTotalsGroupByDates]
	-- Add the parameters for the stored procedure here
	@companyid int,
	@councilid int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @councilid IS NULL
	
    -- Insert statements for procedure here
		SELECT SUM(Amount) as total, C.ParentCompanyID as ID, YEAR(S.PaymentDate) as year, MONTH(S.PaymentDate)  as month,
		dbo.monthYearToDate( MONTH(S.PaymentDate), YEAR(S.PaymentDate)) as dt
		FROM Spend S 
		JOIN vw_CompanyParentGroup  C ON S.Supplier =C.Company AND S.SpendID > 500 AND C.ParentCompanyID=@companyid 
		
		GROUP BY  C.ParentCompanyID, YEAR(S.PaymentDate), MONTH(S.PaymentDate) 
	
	ELSE
		
		SELECT SUM(Amount) as total, C.ParentCompanyID as ID, YEAR(S.PaymentDate) as year, MONTH(S.PaymentDate)  as month,
		dbo.monthYearToDate( MONTH(S.PaymentDate), YEAR(S.PaymentDate)) as dt
		FROM Spend S 
		JOIN vw_CompanyParentGroup  C ON S.Supplier =C.Company AND S.SpendID > 500 AND C.ParentCompanyID=@companyid 
		JOIN SpendDataSet DS ON S.DataSetID = DS.UID AND DS.CouncilID = @CouncilID
		GROUP BY  C.ParentCompanyID, YEAR(S.PaymentDate), MONTH(S.PaymentDate) 
	
	
END

GO