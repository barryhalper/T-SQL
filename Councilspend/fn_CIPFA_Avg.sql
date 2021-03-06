USE [CouncilSpend]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_CIPFA_Avg]    Script Date: 16/09/2020 19:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[fn_CIPFA_Avg]
(
	-- Add the parameters for the function here
	@councilid int,
	@month		int, 
	@year		int
)
RETURNS float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @rtn float, @NumCouncils int

	-- Add the T-SQL statements to compute the return value here
	SET @NumCouncils = (SELECT COUNT(ComparisonOrganisationID)
											FROM  CouncilComparitive 
											WHERE OrganisationID = @councilid)
	
	SET 	@rtn = (									
	SELECT (SUM(Total) / @NumCouncils)
			FROM rpt_CouncilSpendTotal DS
			 --JOIN  SpendDataSet DS ON S.DataSetID = DS.UID  AND S.SpendID > 500
			JOIN (SELECT ComparisonOrganisationID, OrganisationID
					FROM  CouncilComparitive 
						WHERE OrganisationID = @councilid ) AS CC ON DS.id = CC.ComparisonOrganisationID
			
		WHERE DS.month = @month AND DS.year = @year)


	-- Return the result of the function
	RETURN @rtn

END
