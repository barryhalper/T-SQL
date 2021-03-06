USE [CouncilSpend]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_stripNoiseWords]    Script Date: 16/09/2020 19:52:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[fn_stripNoiseWords]
(
	-- Add the parameters for the function here
	@str varchar (4000)
)
RETURNS varchar(150)
AS
BEGIN
	-- Declare the return variable here
	
	DECLARE @Igorne varchar(75)

	DECLARE CursorName CURSOR FAST_FORWARD
						FOR
						
						
							SELECT  word FROM dbo.NoiseWords
							
							OPEN CursorName
							FETCH NEXT FROM CursorName
							INTO @Igorne
							
								 SET @Str = REPLACE(@Str, @Igorne,  '')
								
								    
								WHILE @@FETCH_STATUS = 0
									BEGIN
									FETCH NEXT FROM CursorName
								INTO @Igorne
						 
									  SET @Str = REPLACE(@Str, @Igorne,  '')
								    	
									END
			
			CLOSE CursorName
			DEALLOCATE CursorName
			
			SET  @Str =  RTRIM(LTRIM(@Str))
			SET  @Str =  replace(@Str, '   ', ' ')
			SET  @Str =  replace(@Str, '  ', ' ')
		
			RETURN @Str

END
