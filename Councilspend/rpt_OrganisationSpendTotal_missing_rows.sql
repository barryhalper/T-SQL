USE [CouncilSpend]
GO
/****** Object:  StoredProcedure [dbo].[rpt_OrganisationSpendTotal_missing_rows]    Script Date: 22/09/2020 12:43:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[rpt_OrganisationSpendTotal_missing_rows]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF object_id('tempdb..#temp ') IS NULL


CREATE TABLE #temp
(
   ID int, 
   y int,
   m int	

)


DECLARE @m int, @y int, @id int


DECLARE db_cursor CURSOR FOR 
SELECT DISTINCT Year(S.PaymentDate)y , Month(S.paymentDate) m
FROM SPend S  



OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @y, @m  

WHILE @@FETCH_STATUS = 0  
BEGIN  
      
	  --inner cur

	 --   DECLARE db_cursor_inner CURSOR FOR 
		--SELECT DISTINCT O.Uid
		--FROM Organisation O
		--WHERE  EXISTS(SELECT * FROM SpendDataSet DS WHERE O.Uid = DS.OrganisationID)

		--	OPEN db_cursor_inner  
		--	FETCH NEXT FROM db_cursor_inner INTO @id
		--	WHILE @@FETCH_STATUS = 0  
		--	BEGIN  

				--IF NOT EXISTS (SELECT * FROM SpendDataSet SD1 WHERE SD1.OrganisationID = @id and SD1.Year = @y and SD1.Month = @m) 
				--	INSERT INTO #Temp(id, y, m)
				--	SELECT @ID, @m, @y
				--ELSE
				--IF NOT EXISTS (SELECT * FROM Spend S1 
				--						JOIN SpendDataSet	SD2 ON S1.DataSetID = SD2.UID	 			
				--						WHERE YEAR(S1.PaymentDate) = @y and Month(S1.PaymentDate) = @m)
				INSERT INTO #Temp(id, y, m)
					--SELECT @ID, @m, @y
				SELECT  O.Uid,@y,@m
				FROM Organisation O 
				JOIN SpendDataSet DS ON DS.OrganisationID = O.Uid AND OrganisationTypeid = 5
				LEFT OUTER  JOIN Spend S ON  S.DataSetID = DS.UID AND YEAR(S.PaymentDate) = @y and Month(S.PaymentDate) =@m
				GROUP BY  O.Uid
				HAVING SUm(Amount)  IS NULL

 


			--FETCH NEXT FROM db_cursor_inner INTO @id
			--END
			--CLOSE db_cursor_inner  
			--DEALLOCATE db_cursor_inner
		--inner curs end

      FETCH NEXT FROM db_cursor  INTO @y, @m  
END 

CLOSE db_cursor  
DEALLOCATE db_cursor


INSERT INTO rpt_OrganisationSpendTotal([total], [company], [id], [month], [year], [cipfaAvg], [typeid] )
SELECT  0, O.Name, t.ID, T.m, t.y, 0, O.OrganisationTypeid 
FROM #Temp t
JOIN Organisation O
ON O.Uid = t.ID
WHERE NOT EXISTS (SELECT * FROM rpt_OrganisationSpendTotal R WHERE R.id = O.Uid AND R.year = t.y AND R.month = t.m)

DROP TABLE #Temp


END

GO