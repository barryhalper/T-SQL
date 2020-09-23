/****** Object:  StoredProcedure [dbo].[usp_getStatistics]    Script Date: 22/09/2020 12:43:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_getStatistics]

AS

IF object_id('tempdb..#tempStats ') IS NULL


CREATE TABLE #tempStats
(
	name varchar(50),
	amount varchar(50),
	format varchar(1) null,
)

INSERT INTO #tempStats(name, amount, format)
	SELECT 'Total Spend', SUM(Amount), 'C'
	FROM Spend
	WHERE Amount >0
	
INSERT INTO #tempStats(name, amount, format)
	SELECT  'Total Refund',SUM(Amount), 'C'
	FROM Spend
	WHERE Amount <0
	
INSERT INTO #tempStats(name, amount, format)
	SELECT 'No. Datasets', Count(*), 'N' 
	FROM SpendDataSet
	
INSERT INTO #tempStats(name, amount, format)
	SELECT 'No. Spend Items', Count(*) , 'N' 
	FROM Spend
	
INSERT INTO #tempStats(name, amount, format)
	SELECT 'Last Updated',  MAX(DateLastSaved), 'D' 
	FROM SpendDataSet
	
INSERT INTO #tempStats(name, amount, format)
	SELECT 'First DateSet',   dbo.monthYearToDate(Min([month]), Min([year])), 'D'
	FROM SpendDataSet
	
INSERT INTO #tempStats(name, amount, format)
	SELECT 'Last DateSet',   dbo.monthYearToDate(Max([month]), Max([year])) , 'D' 
	FROM SpendDataSet
	
INSERT INTO #tempStats(name, amount, format)
	SELECT 'No. Councils', Count(DISTINCT CouncilID),  'N' 
	FROM SpendDataSet

SELECT * FROM #tempStats

DROP TABLE #tempStats
GO