USE [CouncilSpend]
GO
/****** Object:  UserDefinedFunction [dbo].[RegExEscape]    Script Date: 16/09/2020 19:52:56 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER FUNCTION [dbo].[RegExEscape](@Input [nvarchar](max))
RETURNS [nvarchar](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [RegexFunction].[SQLRegEx.SimpleTalk.Phil.Factor.RegularExpressionFunctions].[RegExEscape]