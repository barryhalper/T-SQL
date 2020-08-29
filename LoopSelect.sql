DECLARE
@lstTableNames varchar (3000),
@Length int,	  
@StartPos int,	  
@Tablename varchar (100),
@NextPos int,
@SQL varchar (300)

SELECT @lstTableNames = 'TblAddress,tblAddressTelecom,tblAdvert,tblContact,tblOrganisation,tlkpCategory,tlkpCountry,tlkpDirectories,
tlkpOrganisationProduct,trelAddressBrandProduct,trelAddressContact,trelAdvertOrderItem,trelOrganisationCategory,trelOrganisationProduct,
trelOrganisationRelationship'

---set local variable to hold list loop data
SELECT @StartPos = 1,
@Length = LEN(@lstTableNames),
@NextPos = 0

---Begin Loop and continue until start of loop is greatter than its lenght
WHILE @StartPos <= @Length
BEGIN

SELECT @NextPos = CHARINDEX(',', @lstTableNames, @startpos)

 IF @NextPos = 0
  BEGIN
	SET @NextPos = LEN(@lstTableNames) + 1 
  END

  SELECT @Tablename = SUBSTRING(@lstTableNames, @StartPos, (@NextPos - @StartPos))	
   IF @Tablename <> ','

     BEGIN

      SET @SQL = 'SELECT * FROM ' + @Tablename 
      EXEC (@SQL)

     END

 SET @StartPos = @NextPos + 1

END
