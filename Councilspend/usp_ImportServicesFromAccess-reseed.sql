CREATE PROCEDURE [dbo].[usp_ImportServicesFromAccess]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
   TRUNCATE TABLE dbo.SpendServiceType
   
  
   DBCC CHECKIDENT ('dbo.SpendServiceType', RESEED, 1);   

	INSERT INTO dbo.SpendServiceType(SpendID, ServiceTypeID)
	SELECT S.SpendID, SF.ServiceID
	FROM 
	ServiceFromAccess SF 
	JOIN Spend S ON SF.ServiceSpecific = S.Service AND SF.ServiceID IS NOT NULL
	
	--EXEC dbo.usp_matchServiceAlgorithim
	
	--EXEC dbo.usp_matchServiceAlgorithimByCompanies
	

	
END

GO