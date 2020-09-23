/****** Object:  StoredProcedure [dbo].[usp_Process_CompanyUpload]    Script Date: 22/09/2020 12:43:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Process_CompanyUpload]
	 @NumRows int  = NULL OUTPUT 

AS


BEGIN

SET NOCOUNT ON
		
		DELETE FROM CompanyUpload
		WHERE id = 'id'
		
		
		UPDATE C
		SET ParentCompanyID= U.ParentCompanyID
		FROM CompanyUpload U
		JOIN Company C ON CONVERT(int, U.id) = C.CompanyID
		--WHERE  (U.ParentCompanyID!=C.CompanyID)
		
		SET IDENTITY_INSERT Company ON
		-- insert new parent company
		INSERT INTO Company(CompanyID, Company)
		SELECT DISTINCT id,  dbo.UpperCaseFirst(name)
		FROM CompanyUpload U
		WHERE U.id !=0 AND NOT EXISTS (SELECT * FROM Company C WHERE C.CompanyID =  CONVERT(int, U.id))
		
		
		SET IDENTITY_INSERT Company OFF

	    INSERT INTO Company( Company, ParentCompanyID)
		SELECT DISTINCT dbo.UpperCaseFirst(name),  U.parentCompanyID
		FROM CompanyUpload U
		WHERE U.id =0  AND U.parentCompanyID IS NOT NULL 
		AND NOT EXISTS (SELECT * FROM Company C WHERE C.Company = name )
		
		--INSERT INTO Company(Company, ParentCompanyID)
		--SELECT  name, U.parentCompanyID
		--FROM CompanyUpload U
		--WHERE NOT EXISTS (SELECT * FROM Company C WHERE C.CompanyID =  CONVERT(int, U.id))
		--AND U.id != U.parentCompanyID
		
		
		
		EXEC dbo.usp_SaveParentCompanyGroup
		
		SET @NumRows = (SELECT @@rowcount)
		
		
		
END







GO