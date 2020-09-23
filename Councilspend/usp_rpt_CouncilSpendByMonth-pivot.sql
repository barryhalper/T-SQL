CREATE PROCEDURE [dbo].[usp_rpt_CouncilSpendByMonth] 
	-- Add the parameters for the stored procedure here
	 @Year int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
			SELECT * FROM  (
			SELECT  C.Name as Council, SUM(Amount) as total, DateName( month , DateAdd( month , DS.[Month] , -1 ) ) as strMonth
			FROM Spend S
			JOIN SpendDataSet DS ON S.DataSetID = DS.UID
			JOIN Council C ON C.CouncilID = DS.CouncilID
			WHERE DS.Year = @Year
			AND S.Amount > 0
			GROUP BY C.Name, DS.Month
			) T
			PIVOT (SUM(T.total) FOR strMonth   IN (January,February,March,
			  April, May,June,July,August,September,October,November,
			  December) ) P
END

GO