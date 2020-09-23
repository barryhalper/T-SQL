/****** Object:  StoredProcedure [dbo].[usp_Update_LastMonthThreshold]    Script Date: 22/09/2020 12:43:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Update_LastMonthThreshold]

AS

BEGIN



DECLARE @NumOrgs int, @NumInMonth int, @Percentage decimal, @Threshold int, @month int, @year int

SET @Threshold =75

SET @NumOrgs = (SELECT COUNT(O.Uid)
FROM Organisation O
WHERE EXISTS(SELECT * FROM SpendDataSet DS WHERE DS.OrganisationID = O.Uid))

DECLARE Curs CURSOR FOR  
SELECT DISTINCT  MONTH(S.PaymentDate), Year(S.PaymentDate)
FROM  Spend S
ORDER BY  Year(S.PaymentDate) DESC, MONTH(S.PaymentDate) DESC

OPEN Curs; 


FETCH NEXT FROM Curs
INTO @month, @year;  


WHILE @@FETCH_STATUS = 0    
	BEGIN

			SET @NumInMonth =(SELECT COUNT(DISTINCT DS.OrganisationID)
			FROM Spend S
			JOIN SpendDataSet DS ON DS.UID = S.DataSetID
			WHERE  MONTH(S.PaymentDate) = @Month AND Year(S.PaymentDate) =@year )

			SET @Percentage = @NumInMonth * 100.0 / @NumOrgs
			 IF @Percentage >= @Threshold
				BEGIN
						
							INSERT INTO SpendStatistics(name, Date, Format)
							SELECT 'Load Threshold',  DATEADD(mm,1, dbo.DATEFROMPARTS(@Year, @Month, 1))  , 'D'
							

							
					
					--PRINT 'Percentage=' +  Convert(varchar(10), @Percentage) + ' ' +  Convert(varchar(10), @Month) + '/' + Convert(varchar(10), @Year)
					BREAK
				END

	FETCH NEXT FROM Curs
	INTO @month, @year;  
END  


CLOSE Curs;  
DEALLOCATE Curs;  


END



GO
