
--allow null variables to be concatenated
SET CONCAT_NULL_YIELDS_NULL OFF

--refresh temp table by deleting all records
DELETE FROM dbo.tblPubCompanies

---insert main data into temp table
INSERT INTO dbo.tblPubCompanies (CompanyID,CompanyName,Alpha,CompanyType,Contact,Address,Country,Tel,Fax,Email,CompanyStatus,Areas,Profile,
AgentFor,ProductList)
SELECT  [Company ID:] AS CompanyID,[Company Name:] as CompanyName, Left([Listing Initial:], 1) as Alpha,[Advertiser or Listing:] AS CoType, 
	CAST([Listing Contact:] as varchar(255))as Contact,CAST([Listing Address:]as varchar (255))as Address,[Country:] as Country,[Telephone Number:] as Tel,
	[Fax Number:]as Fax,[E-Mail:] as Email,[Web Site:] as Website,[Company Status:] as CompanyStatus,[Areas Covered:] As Areas,
	[Company Profile:] as CompanyProfile, CAST([Agent/Dealer For:]as varchar(500))as AgentFor
FROM dbo.[Tbl Advertisers & Listings]
ORDER BY [Listing Initial:]

--declare local variables
DECLARE @CompID int, @ProdName varchar (60), @companyname  varchar (150), @SQL varchar (200)

--declare cursor to scroll through donor table
DECLARE ProdCurs CURSOR FOR 
SELECT p.[Company ID:] as CompanyID, c.[Company Name:]as CompanyName, p.[Product Categories:] as Products
FROM [Tbl Product Index] p INNER JOIN [Tbl Advertisers & Listings] c ON p.[Company ID:] = c.[Company ID:]
WHERE c.[Company ID:] is not null
ORDER BY c.[Company ID:],  p.[Product Categories:]

Open ProdCurs

--fecth 1st record
FETCH ProdCurs INTO @CompID, @companyname, @ProdName

--begin loop
WHILE (@@fetch_status=0)

	BEGIN
	--fetch all subsequent records
		FETCH ProdCurs INTO @CompID,@companyname,@ProdName

		--perform update whereby I concatenate list of products into existing row
		SET @SQL = 'UPDATE dbo.tblPubCompanies SET ProductList = (ProductList + '', ' + @ProdName + ''') WHERE CompanyID = ' + CAST(@CompID AS VARCHAR (10))

		EXEC(@SQL)

		--PRINT @SQL

		--PRINT  @ProdName
		--PRINT  @CompID
		--PRINT  @companyname

	END

--close and empty cursor
CLOSE ProdCurs
DEALLOCATE ProdCurs

--remove commas from beginning of string
UPDATE dbo.tblPubCompanies
SET ProductList = STUFF(ProductList, 1, 2, '')
WHERE LEFT(ProductList, 2) = ', '