DECLARE @D datetime
SET @D = '22/Nov/2006'


SELECT * FROM sysobjects 
WHERE xtype ='P' and category=0
AND refDate >= @D
ORDER BY refDate DESC  