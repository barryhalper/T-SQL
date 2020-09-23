CREATE PROCEDURE [dbo].[usp_rpt_TopTenDirectoratePerCouncil]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF object_id('tempdb..#tempTotal ') IS NULL

			CREATE TABLE #tempTotal
			(
			   ID int, 
			   TotalAmount float,
			   Directorate varchar(150)
			   	
			)

			DECLARE @id INT
			DECLARE CursorName CURSOR FAST_FORWARD
			FOR

				SELECT C.CouncilID
				FROM Council C 
				WHERE EXISTS (
				SELECT * FROM SpendDataSet DS WHERE C.CouncilID  = DS.CouncilID
				)

			OPEN CursorName
			FETCH NEXT FROM CursorName

			INTO @id
			WHILE @@FETCH_STATUS = 0
				BEGIN
						
						INSERT INTO #tempTotal(TotalAmount, Directorate,ID)
						SELECT TOP 10  SUM(Amount) as TotalAmount, Directorate,DS.CouncilID
						FROM Spend S
						JOIN SpendDataSet  DS ON DataSetID = DS.UID WHERE DS.CouncilID = @id
						GROUP BY Directorate, DS.CouncilID
					
					
						FETCH NEXT FROM CursorName
					INTO @id
				END

			CLOSE CursorName
			DEALLOCATE CursorName


			SELECT C.Name, TotalAmount, Directorate
			FROM Council C
			JOIN #tempTotal ON ID = CouncilID
			ORDER BY C.Name, TotalAmount DESC

			DROP TABLE #tempTotal
END

GO
