CREATE PROCEDURE  [dbo].[usp_CleanUnWantedSpendData]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET DATEFORMAT DMY

	DELETE FROM Spend 
	WHERE Amount < 500

	DELETE  FROM Spend
	WHERE PaymentDate > GETDATE()
	
	DELETE FROM Spend
	WHERE PaymentDate < '01/04/2014'
	
	/*CLEAN ORPHAN RECORDS*/
	DELETE  ST
	FROM dbo.SpendServiceType ST
	WHERE NOT EXISTS (SELECT * FROM Spend S WHERE S.SpendID = ST.SpendID)
	
	DELETE S
	FROM  Spend S 
	WHERE NOT EXISTS (SELECT * FROM SpendDataSet DS WHERE S.DataSetID = DS.UID)
	
	--clean company name
	UPDATE Company
	SET Company = dbo.ProperCase(Company)

	--remove empty temp tables

	DECLARE @SQL varchar(4000)

	SELECT @SQL = COALESCE(@sql, '') + 'DROP TABLE [' + TABLE_NAME + ']' + CHAR(13) + CHAR(10)
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME LIKE  'spendCsVTemp%'


   EXEC (@sql)
	
END

GO