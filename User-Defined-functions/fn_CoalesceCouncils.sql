USE [MYB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_CoalesceCouncils]    Script Date: 16/09/2020 19:31:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER  function [dbo].[fn_CoalesceCouncils]
(@ID int, @AttributeID int)
returns varchar(4000)
as
/* takes an ID of Parish assocication and concatenates the related Parish councils into a comma (& space) separated string
*/
BEGIN
	
	DECLARE @Value varchar(4000)
	
		
		/*limit functions to those specefied*/
		SELECT @Value = COALESCE(@Value + ', ', '') + CONVERT(varchar(150), O.Organisation)
		FROM    AttributeData AD
		INNER 	JOIN Attribute A	
		ON   	AD.AttributeID = A.AttributeID
		INNER	JOIN Organisation O
		ON	AD.EntityID=O.OrganisationID
		WHERE  A.AttributeID = @AttributeID
		AND 	AD.AttributeData = @ID

	
	RETURN @Value
END
