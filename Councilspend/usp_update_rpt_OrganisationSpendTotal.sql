CREATE PROCEDURE [dbo].[usp_update_rpt_OrganisationSpendTotal]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	TRUNCATE TABLE rpt_OrganisationSpendTotal
    
	INSERT INTO dbo.rpt_OrganisationSpendTotal(total, company, id, month, year, typeid)
	SELECT SUM(Amount),  O.Name, O.Uid, Month(S.PaymentDate) as m, Year(S.PaymentDate) as y, O.OrganisationTypeid
	FROM Spend S
	JOIN  SpendDataSet DS ON S.DataSetID = DS.UID 
	JOIN Organisation  O ON  O.Uid = DS.OrganisationID AND O.OrganisationTypeid = 5
	GROUP BY  O.Name, O.Uid,Month(S.PaymentDate), Year(S.PaymentDate), O.OrganisationTypeid
	
	--add missing row to table so that CIPFA Avg can be calculated even for row that are zero
	EXEC rpt_OrganisationSpendTotal_missing_rows

	
	UPDATE C
	SET cipfaAvg = dbo.fn_CIPFA_Avg(id, MONTH, YEAR)
	FROM dbo.rpt_OrganisationSpendTotal  C
	--WHERE NOT EXISTS (SELECT * FROM  dbo.rpt_CouncilSpendTotal C WHERE C.id = ID AND C.month = Month  AND C.year =  Year)
	
END

GO
