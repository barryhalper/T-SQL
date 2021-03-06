USE [MYB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_CoalesceOfficerFunctions]    Script Date: 16/09/2020 19:35:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


ALTER function [dbo].[fn_CoalesceOfficerFunctions]
(@ID int,@FunctionID varchar(1000)=null)
returns varchar(4000)
as
/* takes a PersonID and concatenates the related Funtions(s) into a comma (& space) separated string
*/
BEGIN
	
	DECLARE @Value varchar(500)
	/*check if specfic function(s) have been passed*/
	IF  @FunctionID IS NULL 
		Begin
		SELECT @Value = COALESCE(@Value + ',', '') + CONVERT(varchar(5), F.FunctionID)
		FROM	Organisation O,
		[Function] F,
		OrganisationFunction FO
		WHERE	O.OrganisationTypeID = 5
		AND	F.FunctionTypeID = 1
		AND	O.OrganisationID = FO.OrganisationID
		AND	FO.FunctionID = F.FunctionID
		AND 	FO.PersonID =@ID
		end
	
	ELSE
		Begin
		/*limit functions to those specefied*/
		SELECT @Value = COALESCE(@Value + ',', '') + CONVERT(varchar(5), F.FunctionID)
		FROM	Organisation O,
		[Function] F,
		OrganisationFunction FO
		WHERE	O.OrganisationTypeID = 5
		AND	F.FunctionTypeID = 1
		AND	O.OrganisationID = FO.OrganisationID
		AND	FO.FunctionID = F.FunctionID
		AND 	FO.PersonID =@ID
		AND     F.FunctionID IN  (SELECT value FROM fn_ConvertToTable(@FunctionID))
		end
	
	RETURN @Value
END








