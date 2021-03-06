USE [MYB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ConvertToTable]    Script Date: 16/09/2020 19:30:46 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER     Function [dbo].[fn_ConvertToTable](@List varchar(8000)='')

Returns @TableValues table (Value INT NOT NULL)
		

/*
Code Header
=============================================================
Purpose   : To take a string of Numbers separated by commas and turn them into a table
Author    : barry halper, 04-05-2004
Notes     : 
-------------------------------------------------------------
Parameters
-----------
@List varchar(8000): The actual list of words/numbers
------------------------------------------------------------
Returns   :
@Values Table	: A table result set of the @List string split into rows
-------------------------------------------------------------
Revision History
-------------------------------------------------------------
04-05-2004 DJ :
=============================================================
End Code Header block
*/
As
Begin





Declare 
	@Value INT,
	@Temp varchar(500),
	@delimPos INT


	Begin
		If Ltrim(@List)=''
			GOTO Ignore_All
		Set @Temp=@List
		Set @Temp=Ltrim(rtrim(@Temp))
	End

While len(@Temp)>0
	Begin
		--Get the first comma character
		Set @delimPos=charindex(',',@Temp)
		If @delimPos=0
			Begin
				Set @Value=@Temp
				Set @Temp=''
			End
		Else
			Begin
				Set @Value=Left(@Temp,@delimPos-1)
				Set @Temp=Ltrim(Right(@Temp,Len(@Temp)-@delimPos))
			End
Insert_Word:	
		If Len(@Value)=0
			GOTO Next_Word
		Insert into @TableValues(Value)
		Select @Value
Next_Word:
	End --While
	Return
Ignore_All:
	Return
END --ALL






































