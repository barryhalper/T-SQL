-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateSpendServiceType_FromMapping]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

/*DELETE PREVIOUS ALLOCATED SPEND ITEMS*/




 MERGE SpendServiceType T 
 USING 
	(SELECT  S.SpendID, SM.ServiceTypeID
	FROM Spend S
	JOIN ServiceMapping SM ON RTRIM(LTRIM(S.Service)) = RTRIM(LTRIM(SM.SuppliedService))
	JOIN SpendDataSet ds on ds.[UID] = S.[DataSetID]
	JOIN Organisation O ON O.[UID] =DS.[OrganisationID] AND O.OrganisationTypeID = 5
	) SO
	ON (SO.SpendID = T.SpendID AND T.ServiceTypeID != So.ServiceTypeID)
	WHEN MATCHED 
	THEN 
	UPDATE 
	SET T.ServiceTypeID = SO.ServiceTypeID
	WHEN NOT MATCHED BY TARGET
	THEN
	INSERT (SpendID, ServiceTypeID)
	VALUES (SO.SpendID, SO.ServiceTypeID);



END

GO