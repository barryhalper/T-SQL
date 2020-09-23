--=============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_getTotalSpendByCouncils]
	-- Add the parameters for the stored procedure here
	@CouncilIDs varchar(150),
	@IncludeAverage bit = false
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF object_id('tempdb..#tempSpend ') IS NULL


CREATE TABLE #tempSearch
(
    total float, 
    company varchar(200),
   	id int,
	[month] int, 
	[year] int,
	dt DateTime
)

	DECLARE @StartDate DateTIme, @EndDate dateTime, @NumCouncils int, @MaxID int 
	

	
	INSERT INTO #tempSearch (total, company, id,[month], [year], dt) 
    -- Insert statements for procedure here
	SELECT SUM(Amount) as total, CO.Name as company, CO.CouncilID as id, DS.Month, DS.Year,
	dbo.monthYearToDate(DS.Month, DS.Year)
	FROM Spend S
	JOIN  SpendDataSet DS ON S.DataSetID = DS.UID AND S.SpendID > 500
	JOIN Council CO ON  CO.CouncilID = DS.CouncilID
	JOIN dbo.fn_ConvertStringToTable(@CouncilIDs) FN ON FN.Value = CO.CouncilID 
	GROUP BY  CO.Name, CO.CouncilID, DS.Month, DS.Year
	
	
	IF @IncludeAverage = 1
	BEGIN
	
			SET @StartDate = (SELECT MIN(dt) FROM #tempSearch)
			SET @EndDate = (SELECT MAX(dt) FROM #tempSearch)
			SET @MaxID = (SELECT MAX(id) FROM #tempSearch)
			SET @NumCouncils = (SELECT COUNT(ComparisonOrganisationID)
											FROM  CouncilComparitive 
											WHERE OrganisationID = @MaxID)
	
		    INSERT INTO #tempSearch (total, company, id,[month], [year]) 
			SELECT (SUM(Amount) / @NumCouncils) as total, 'CIPFA Average' as company, 0 as id, DS.Month, DS.Year
			FROM Spend S
			 JOIN  SpendDataSet DS ON S.DataSetID = DS.UID  AND S.SpendID > 500
			JOIN (SELECT ComparisonOrganisationID, OrganisationID
					FROM  CouncilComparitive 
						WHERE OrganisationID = @MaxID ) AS CC ON DS.CouncilID = CC.ComparisonOrganisationID
			
			WHERE dbo.monthYearToDate(DS.Month, DS.Year) BETWEEN @StartDate AND @EndDate
			GROUP BY DS.Month, DS.Year
	
	
	
	END
	
	SELECT * FROM #tempSearch
	
	DROP TABLE #tempSearch
	
	
END


GO