USE [MYB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_PersontoString]    Script Date: 16/09/2020 19:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER         function [dbo].[fn_PersontoString]
(@ID int)
returns varchar(4000)
as
/* takes a PersonID  concatenates all person fields into a single variable   
*/
BEGIN
	
	DECLARE @Value varchar(4000)
	/*check if specfic function(s) have been passed*/
	
		
		SELECT @Value = 
			LTRIM(REPLACE(
			CASE WHEN P.Title IS NULL THEN '' ELSE RTRIM(LTRIM(P.Title)) + ' ' END + 
			CASE WHEN P.Forename IS NULL THEN 
					CASE WHEN P.Initial IS NULL THEN '' ELSE P.Initial + ' ' end

				 ELSE  RTRIM(LTRIM(P.Forename))  + ' '   END +
			CASE WHEN P.Surname 	IS NULL THEN ' ' ELSE RTRIM(LTRIM(P.Surname  + ' '))  END + 	
			CASE WHEN P.Suffix 	IS NULL THEN ' ' ELSE ''  END, '  ', ' '))
             	FROM  Person P
		WHERE PersonID = @ID
		
	
	RETURN @Value
END


