SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwActivities]
AS
SELECT p_activity_id AS ActivityID, activity
FROM dbo.tblBIGActivities


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwAdInfo]
AS
SELECT     p_ad_id, NumberClicks, LastClicked, website
FROM         dbo.tblAdverts



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwAdPositions]
AS
SELECT dbo.tblAdPositions.p_adposition_id, 
    dbo.tblAdPositions.f_ad_id, dbo.tblAdPositions.f_adtype_id, 
    dbo.tblAdTypes.ad_type, dbo.tblAdPositions.f_directory_id, 
    dbo.tblDirectory.directory
FROM dbo.tblAdPositions INNER JOIN
    dbo.tblAdTypes ON 
    dbo.tblAdPositions.f_adtype_id = dbo.tblAdTypes.p_adtype_id INNER
     JOIN
    dbo.tblDirectory ON 
    dbo.tblAdPositions.f_directory_id = dbo.tblDirectory.p_directory_id


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwAdStats]
AS
SELECT tblAdverts.p_ad_id, tblAdverts.company_name, 
    tblAdverts.image_name, tblAdverts.website, 
    tblAdverts.date_start, tblAdverts.date_end, 
    tblAdverts.NumberClicks, tblAdverts.LastClicked, 
    tblAdverts.GrossRate, tblAdverts.NetRatePounds, 
    tblAdPositions.f_adtype_id AS AdTypeID, 
    tblAdRep.forename + ' ' + tblAdRep.surname AS RepName, 
    tblAdverts.SignedOrderReceived, tblAdverts.InvoiceRaised, 
    tblAdverts.NetRate
FROM dbo.tblAdverts LEFT OUTER JOIN
    dbo.tblAdRep ON 
    dbo.tblAdverts.f_rep_id = dbo.tblAdRep.p_rep_id LEFT OUTER JOIN
    dbo.tblAdPositions ON 
    dbo.tblAdverts.p_ad_id = dbo.tblAdPositions.f_ad_id
GROUP BY dbo.tblAdverts.p_ad_id, dbo.tblAdverts.NumberClicks, 
    dbo.tblAdverts.LastClicked, dbo.tblAdverts.image_name, 
    dbo.tblAdverts.website, dbo.tblAdverts.date_end, 
    dbo.tblAdverts.company_name, dbo.tblAdverts.GrossRate, 
    dbo.tblAdverts.NetRatePounds, 
    dbo.tblAdPositions.f_adtype_id, dbo.tblAdverts.date_start, 
    dbo.tblAdRep.forename + ' ' + dbo.tblAdRep.surname, 
    dbo.tblAdverts.SignedOrderReceived, 
    dbo.tblAdverts.InvoiceRaised, dbo.tblAdverts.NetRate


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwArticles]
AS
SELECT dbo.tblArticles.p_articles_id AS ArticleID, 
    dbo.tblArticles.headline_banner, dbo.tblArticles.story, 
    dbo.tblArticles.byline, 
    dbo.tblArticles.f_article_type_id AS ArticleTypeID, 
    dbo.tblArticles.headline, dbo.tblArticles.date_posted, 
    dbo.tblArticles.author, dbo.tblArticles.image, 
    dbo.tblArticles.f_IssueCode, dbo.tblArticles.date_commence, 
    dbo.tblIssues.ISSUEDATE, dbo.tblArticles.image_caption
FROM dbo.tblArticles LEFT OUTER JOIN
    dbo.tblIssues ON 
    dbo.tblArticles.f_IssueCode = dbo.tblIssues.ISSUECODE


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwBIGAds]
AS
SELECT dbo.tblAdverts.p_ad_id, 
    dbo.tblBIGCompanies.company_name, 
    dbo.tblAdverts.image_name, dbo.tblAdverts.website, 
    dbo.tblAdverts.date_end, dbo.tblAdverts.date_start, 
    dbo.tblAdverts.LastClicked, dbo.tblAdverts.NumberClicks, 
    dbo.tblAdverts.GrossRate, dbo.tblAdverts.NetRate, 
    dbo.tblAdverts.SignedOrderReceived, 
    dbo.tblAdverts.InvoiceRaised, dbo.tblAdPositions.f_adtype_id, 
    dbo.tblAdRep.forename + ' ' + dbo.tblAdRep.surname AS RepName,
     dbo.tblBIGCompanies.p_company_id
FROM dbo.tblAdverts INNER JOIN
    dbo.tblAdPositions ON 
    dbo.tblAdverts.p_ad_id = dbo.tblAdPositions.p_adposition_id INNER
     JOIN
    dbo.tblBIGCompanies ON 
    dbo.tblAdverts.f_BIGCompany_id = dbo.tblBIGCompanies.p_company_id
     LEFT OUTER JOIN
    dbo.tblAdRep ON 
    dbo.tblAdverts.f_rep_id = dbo.tblAdRep.p_rep_id
GROUP BY dbo.tblAdverts.p_ad_id, 
    dbo.tblBIGCompanies.company_name, 
    dbo.tblAdverts.image_name, dbo.tblAdverts.website, 
    dbo.tblAdverts.date_end, dbo.tblAdverts.date_start, 
    dbo.tblAdverts.LastClicked, dbo.tblAdverts.NumberClicks, 
    dbo.tblAdverts.GrossRate, dbo.tblAdverts.NetRate, 
    dbo.tblAdverts.SignedOrderReceived, 
    dbo.tblAdverts.InvoiceRaised, dbo.tblAdPositions.f_adtype_id, 
    dbo.tblAdRep.forename + ' ' + dbo.tblAdRep.surname, 
    dbo.tblBIGCompanies.p_company_id
HAVING (dbo.tblAdPositions.f_adtype_id = 3)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwCompanyDetails]
AS
SELECT tblBIGCompanies.p_company_id AS CompanyID, 
    tblBIGCompanies.company_name, tblBIGCompanies.add1, 
    tblBIGCompanies.add2, tblBIGCompanies.add3, 
    tblBIGCompanies.town, tblBIGCompanies.county, 
    tblBIGCompanies.PostCode, tblCountries.country, 
    tblBIGCompanies.tel, tblBIGCompanies.fax, 
    tblBIGCompanies.email, tblBIGCompanies.web, 
    tblBIGCompanies.salutation, tblBIGCompanies.forename, 
    tblBIGCompanies.surname, tblBIGCompanies.job_title, 
    tblBIGCompanies.editorial, 
    tblBIGCompanies.percent_related_business AS PercentBusiness,
     tblBIGCompanies.prof_engineers_employed AS NumEngineers,
     tblBIGCompanies.advertiser, tblBIGCompanies.AdEndDate, 
    tblBIGCompanies.AdFileName, 
    tblBIGCompanies.AdStartDate
FROM dbo.tblBIGCompanies INNER JOIN
    dbo.tblCountries ON 
    dbo.tblBIGCompanies.f_country_id = dbo.tblCountries.p_country_id


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwCompanyDetails]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vwCompanyProducts
AS
SELECT dbo.tblBIGCompanies.p_company_id AS CompanyID, 
    dbo.tblBIGCompanies.company_name, 
    dbo.tblBIGCompanies.add1, dbo.tblBIGCompanies.add2, 
    dbo.tblBIGCompanies.add3, dbo.tblBIGCompanies.town, 
    dbo.tblBIGCompanies.county, dbo.tblBIGCompanies.PostCode, 
    dbo.tblCountries.country, dbo.tblBIGCompanies.tel, 
    dbo.tblBIGCompanies.fax, dbo.tblBIGCompanies.email, 
    dbo.tblBIGCompanies.web, dbo.tblBIGCompanies.salutation, 
    dbo.tblBIGCompanies.forename, 
    dbo.tblBIGCompanies.surname, 
    dbo.tblBIGCompanies.job_title, dbo.tblBIGCompanies.editorial, 
    dbo.tblBIGCompanies.percent_related_business AS PercentBusiness,
     dbo.tblBIGCompanies.prof_engineers_employed AS NumEngineers,
     dbo.tblBIGCompanies.advertiser, 
    dbo.tblBIGCompanies.AdEndDate, 
    dbo.tblBIGCompanies.AdFileName, 
    dbo.tblBIGCompanies.AdStartDate, 
    dbo.tblBIGProductEntries.f_products_id AS ProductID, 
    dbo.tblBIGCompanies.sort_order, 
    dbo.tblBIGCompanies.FormReturned
FROM dbo.tblBIGCompanies INNER JOIN
    dbo.tblBIGProductEntries ON 
    dbo.tblBIGCompanies.p_company_id = dbo.tblBIGProductEntries.f_company_id
     INNER JOIN
    dbo.tblCountries ON 
    dbo.tblBIGCompanies.f_country_id = dbo.tblCountries.p_country_id
WHERE (dbo.tblBIGCompanies.FormReturned = 1)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwContacts]
AS
SELECT p_contact_id, forename, surname, tel, email,
    job_title
FROM dbo.tblContacts



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwContacts]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwContracts]
AS
SELECT p_contract_id AS ContractID, contract
FROM dbo.tblContractTypes


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwContracts]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwCountries]
AS
SELECT p_country_id AS CountryID, country
FROM dbo.tblCountries


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwCountries]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwEmployers]
AS
SELECT     p_employer_id, company_name, address1, address2, address3, town, county, postcode, f_region_id, f_country_id, website, f_service_id, username, 
                      password, active_sub, subscription_date, subscription_date_end, f_salutation_id, forename, surname, job_title, email, logo
FROM         dbo.tblEmployers


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwEmployers]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwEvents]
AS
SELECT dbo.tblEvents.p_event_id, dbo.tblEvents.event_name, 
    dbo.tblEvents.organiser, dbo.tblEvents.date_start, 
    dbo.tblEvents.date_end, dbo.tblEvents.venue_name, 
    dbo.tblEvents.venue_address1, 
    dbo.tblEvents.venue_address2, 
    dbo.tblEvents.venue_address3, dbo.tblEvents.town, 
    dbo.tblEvents.county, dbo.tblEvents.f_country_id, 
    dbo.tblEvents.tel, dbo.tblEvents.fax, dbo.tblEvents.email, 
    dbo.tblEvents.website, dbo.tblEvents.contact_forename, 
    dbo.tblEvents.contact_surname, dbo.tblEvents.contact_tel, 
    dbo.tblEvents.contact_fax, 
    dbo.tblEvents.paper_calls_forename, 
    dbo.tblEvents.paper_calls_surname, 
    dbo.tblEvents.paper_calls_tel, dbo.tblEvents.paper_calls_fax, 
    dbo.tblEvents.paper_calls_email, 
    dbo.tblEvents.contact_salutationID, 
    dbo.tblEvents.contact_email, 
    dbo.tblEvents.paper_calls_salutationID, 
    dbo.tblEvents.paper_call, dbo.tblEvents.detail, 
    dbo.tblEvents.paper_call_detail, 
    dbo.tblEvents.paper_call_deadline, dbo.tblCountries.country, 
    dbo.tblEvents.LogoFileName
FROM dbo.tblEvents LEFT OUTER JOIN
    dbo.tblCountries ON 
    dbo.tblEvents.f_country_id = dbo.tblCountries.p_country_id


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwEvents]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwFormProductListings]
AS
SELECT dbo.tblBIGProducts.p_products_id, 
    dbo.tblBIGProducts.product, dbo.tblBIGActivities.activity
FROM dbo.tblBIGProducts INNER JOIN
    dbo.tblBIGActivities ON 
    dbo.tblBIGProducts.f_activity_id = dbo.tblBIGActivities.p_activity_id


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwFormProductListings]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwGetAdReps]
AS
SELECT forename, surname, area, p_rep_id
FROM dbo.tblAdRep


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwGetAdReps]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vwGetAds
AS
SELECT tblAdverts.p_ad_id AS AdID, tblAdverts.company_name, 
    tblAdverts.image_name, tblAdverts.website, 
    tblAdverts.date_end, tblDirectory.directory, 
    tblAdPositions.f_adtype_id AS AdTypeID, 
    tblAdverts.f_BIGCompany_id, tblAdverts.NumberClicks, 
    tblAdverts.LastClicked, tblAdverts.GrossRate, 
    tblAdverts.NetRate, tblAdverts.NetRatePounds, 
    tblAdverts.SignedOrderReceived, tblAdverts.InvoiceRaised, 
    tblAdverts.date_start, tblAdverts.pubseq
FROM dbo.tblAdverts INNER JOIN
    dbo.tblAdPositions ON 
    dbo.tblAdverts.p_ad_id = dbo.tblAdPositions.f_ad_id INNER JOIN
    dbo.tblDirectory ON 
    dbo.tblAdPositions.f_directory_id = dbo.tblDirectory.p_directory_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwGetAds]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwGetTemplates]
AS
SELECT tblTemplates.p_page_id AS PageID, tblTemplates.header, 
    tblTemplates.content, tblTemplates.cfm_template, 
    tblDirectory.directory, tblTemplates.f_directory_id, 
    tblTemplates.description, 
    tblDirectory.directory + '/' + tblTemplates.cfm_template AS TemplatePath
FROM dbo.tblTemplates INNER JOIN
    dbo.tblDirectory ON 
    dbo.tblTemplates.f_directory_id = dbo.tblDirectory.p_directory_id


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwGetTemplates]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vwIndexAlphas
AS
SELECT DISTINCT LEFT(sort_order, 1) AS Alpha
FROM         dbo.vwIndexCompanies

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vwIndexCompanies
AS
SELECT dbo.tblBIGCompanies.company_name, 
    dbo.tblPages.CompanyID, dbo.tblPages.CompanyPageNo, 
    dbo.tblBIGCompanies.sort_order, 
    LEFT(dbo.tblBIGCompanies.sort_order, 1) AS Alpha
FROM dbo.tblBIGCompanies INNER JOIN
    dbo.tblPages ON 
    dbo.tblBIGCompanies.p_company_id = dbo.tblPages.CompanyID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwIssues]
AS
SELECT p_issue_id, ISSUECODE, ISSUEDATE, LEFT(ISSUECODE, 
    4) + ' - ' + RIGHT(ISSUECODE, 2) AS IssueName, 
    cover_image
FROM dbo.tblIssues


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwIssues]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwJobSeekers]
AS
SELECT p_jobseeker_id AS JobSeekerID, forename, surname, 
    email, password, receive_email, receive_html
FROM dbo.tblJobSeekers


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwJobSeekers]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwJobs]
AS
SELECT dbo.tblJobs.p_job_id, dbo.tblJobs.f_employer_id, 
    dbo.tblJobs.job_title, dbo.tblJobs.description, 
    dbo.tblJobs.experience, dbo.tblJobs.package, 
    dbo.tblJobs.application_method, 
    dbo.tblJobs.salary_per_annum, 
    dbo.tblJobs.application_deadline, dbo.tblJobs.date_posted, 
    dbo.tblJobs.f_salutation_id, dbo.tblJobs.forename, 
    dbo.tblJobs.surname, 
    dbo.tblJobs.position AS ContactPosition, dbo.tblJobs.tel, 
    dbo.tblJobs.fax, dbo.tblJobs.email, 
    dbo.tblJobs.f_salary_range_id, dbo.tblJobs.f_contract_id, 
    dbo.tblJobs.status, dbo.tblJobs.f_country_id, 
    dbo.tblContractTypes.contract, 
    dbo.tblSalaryRanges.salary_range, dbo.tblCountries.country, 
    dbo.tblJobs.f_position_id, dbo.tblJobs.f_language_id, 
    dbo.tblJobs.f_qualification_id, dbo.tblJobPositions.position, 
    dbo.tblLanguages.language, dbo.tblQualifications.qualification, 
    dbo.tblEmployers.company_name, 
    dbo.tblEmployers.address1, dbo.tblEmployers.address2, 
    dbo.tblEmployers.address3, dbo.tblEmployers.town, 
    dbo.tblEmployers.county, dbo.tblEmployers.postcode, 
    dbo.tblEmployers.website, dbo.tblEmployers.logo
FROM dbo.tblJobs INNER JOIN
    dbo.tblContractTypes ON 
    dbo.tblJobs.f_contract_id = dbo.tblContractTypes.p_contract_id INNER
     JOIN
    dbo.tblEmployers ON 
    dbo.tblJobs.f_employer_id = dbo.tblEmployers.p_employer_id LEFT
     OUTER JOIN
    dbo.tblCountries ON 
    dbo.tblJobs.f_country_id = dbo.tblCountries.p_country_id LEFT OUTER
     JOIN
    dbo.tblSalaryRanges ON 
    dbo.tblJobs.f_salary_range_id = dbo.tblSalaryRanges.p_salary_range_id
     LEFT OUTER JOIN
    dbo.tblJobPositions ON 
    dbo.tblJobs.f_position_id = dbo.tblJobPositions.p_position_id LEFT
     OUTER JOIN
    dbo.tblLanguages ON 
    dbo.tblJobs.f_language_id = dbo.tblLanguages.p_language_id LEFT
     OUTER JOIN
    dbo.tblQualifications ON 
    dbo.tblJobs.f_qualification_id = dbo.tblQualifications.p_qualification_id


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwJobs]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwLanguages]
AS
SELECT p_language_id AS LanguageID, language, sort_order
FROM dbo.tblLanguages


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwLanguages]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwLinks]
AS
SELECT     p_link_id, title, WebAddress
FROM         dbo.tblLinks


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwLinks]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwMaxEventID]
AS
SELECT MAX(p_event_id) AS MaxEventID
FROM dbo.tblEvents


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwMaxEventID]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwNonBIGAdvertisers]
AS
SELECT tblBIGCompanies.p_company_id, 
    tblBIGCompanies.company_name, 
    tblAdverts.f_BIGCompany_id
FROM dbo.tblAdverts RIGHT OUTER JOIN
    dbo.tblBIGCompanies ON 
    dbo.tblAdverts.f_BIGCompany_id = dbo.tblBIGCompanies.p_company_id
WHERE (dbo.tblAdverts.f_BIGCompany_id IS NULL)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwNonBIGAdvertisers]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwPositions]
AS
SELECT p_position_id AS PositionID, position
FROM dbo.tblJobPositions


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwPositions]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vwPrductIndex
AS
SELECT dbo.tblPages.ProductID, dbo.tblPages.ProductPagNo, 
    dbo.tblBIGProducts.product, 
    dbo.tblBIGProducts.f_activity_id AS ActivityID
FROM dbo.tblPages INNER JOIN
    dbo.tblBIGProducts ON 
    dbo.tblPages.ProductID = dbo.tblBIGProducts.p_products_id

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwProductListings]
AS
SELECT     dbo.tblBIGProductEntries.f_company_id AS CompanyID, dbo.tblBIGProducts.product, dbo.tblBIGActivities.activity
FROM         dbo.tblBIGActivities INNER JOIN
                      dbo.tblBIGProducts ON dbo.tblBIGActivities.p_activity_id = dbo.tblBIGProducts.f_activity_id RIGHT OUTER JOIN
                      dbo.tblBIGProductEntries ON dbo.tblBIGProducts.p_products_id = dbo.tblBIGProductEntries.f_products_id


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwProductListings]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwProducts]
AS
SELECT     p_products_id AS ProductID, product, f_activity_id AS ActivityID
FROM         dbo.tblBIGProducts


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwProducts]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwProjectAreas]
AS
SELECT p_area_id AS AreaID, area
FROM dbo.tblProjectAreas


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwProjectAreas]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwProjectLinks]
AS
SELECT p_link_id, project, comments, f_area_id AS AreaID, 
    webaddress
FROM dbo.tblProjectLinks


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwProjectLinks]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vwRegionListings
AS
SELECT dbo.tblBIGRegionEntries.f_company_id AS CompanyID, 
    dbo.tblRegions.region
FROM dbo.tblBIGRegionEntries INNER JOIN
    dbo.tblRegions ON 
    dbo.tblBIGRegionEntries.f_region_id = dbo.tblRegions.p_region_id

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwRegionListings]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vwRegionalListings
AS
SELECT dbo.tblBIGRegionEntries.p_regionentry_id AS RegionEntryID,
     dbo.tblBIGRegionEntries.f_company_id AS CompanyID, 
    dbo.tblRegions.region, dbo.tblRegions.abreviation
FROM dbo.tblBIGRegionEntries INNER JOIN
    dbo.tblRegions ON 
    dbo.tblBIGRegionEntries.f_region_id = dbo.tblRegions.p_region_id

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwRegionalListings]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwRegions]
AS
SELECT     p_region_id, region
FROM         dbo.tblRegions


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwRegions]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwSalaryRanges]
AS
SELECT p_salary_range_id, salary_range, pubseq
FROM dbo.tblSalaryRanges


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwSalaryRanges]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwSalutations]
AS
SELECT p_salutation_id AS SalutationID, Salutation
FROM dbo.tblSalutations


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwSalutations]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwSearchCompanies]
AS
SELECT     dbo.tblBIGCompanies.company_name, dbo.tblBIGCompanies.p_company_id AS CompanyID, dbo.tblBIGProducts.f_activity_id, 
                      dbo.tblBIGCompanies.sort_order, dbo.tblBIGRegionEntries.f_region_id
FROM         dbo.tblBIGRegionEntries RIGHT OUTER JOIN
                      dbo.tblBIGCompanies ON dbo.tblBIGRegionEntries.f_company_id = dbo.tblBIGCompanies.p_company_id LEFT OUTER JOIN
                      dbo.tblBIGProducts INNER JOIN
                      dbo.tblBIGProductEntries ON dbo.tblBIGProducts.p_products_id = dbo.tblBIGProductEntries.f_products_id ON 
                      dbo.tblBIGCompanies.p_company_id = dbo.tblBIGProductEntries.f_company_id


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwSearchCompanies]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwServiceTypes]
AS
SELECT     p_service_id, service
FROM         dbo.tblServiceTypes


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwServiceTypes]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwUnionAdvertisers]
AS
SELECT tblAdverts.p_ad_id, tblAdverts.company_name, 
    tblAdverts.image_name, tblAdverts.website, 
    tblAdverts.date_start, tblAdverts.date_end, 
    tblAdverts.NumberClicks, tblAdverts.LastClicked, 
    tblAdverts.GrossRate, 
    tblAdPositions.f_adtype_id AS AdTypeID, 
    tblAdRep.forename + ' ' + tblAdRep.surname AS RepName, 
    tblAdverts.SignedOrderReceived, tblAdverts.InvoiceRaised, 
    tblAdverts.NetRate, tblAdverts.NetRatePounds
FROM dbo.tblAdverts LEFT OUTER JOIN
    dbo.tblAdRep ON 
    dbo.tblAdverts.f_rep_id = dbo.tblAdRep.p_rep_id LEFT OUTER JOIN
    dbo.tblAdPositions ON 
    dbo.tblAdverts.p_ad_id = dbo.tblAdPositions.f_ad_id
GROUP BY dbo.tblAdverts.p_ad_id, dbo.tblAdverts.NumberClicks, 
    dbo.tblAdverts.LastClicked, dbo.tblAdverts.image_name, 
    dbo.tblAdverts.website, dbo.tblAdverts.date_end, 
    dbo.tblAdverts.company_name, dbo.tblAdverts.GrossRate, 
    dbo.tblAdverts.NetRatePounds, 
    dbo.tblAdPositions.f_adtype_id, dbo.tblAdverts.date_start, 
    dbo.tblAdRep.forename + ' ' + dbo.tblAdRep.surname, 
    dbo.tblAdverts.SignedOrderReceived, 
    dbo.tblAdverts.InvoiceRaised, dbo.tblAdverts.NetRate, 
    tblAdverts.NetRatePounds
HAVING (dbo.tblAdPositions.f_adtype_id IN (1, 6))
UNION
SELECT tblAdverts.p_ad_id, tblBIGCompanies.company_name, 
    tblAdverts.image_name, tblAdverts.website, 
    tblAdverts.date_start, tblAdverts.date_end, 
    tblAdverts.NumberClicks, tblAdverts.LastClicked, 
    tblAdverts.GrossRate, 
    tblAdPositions.f_adtype_id AS AdTypeID, 
    tblAdRep.forename + ' ' + tblAdRep.surname AS RepName, 
    tblAdverts.SignedOrderReceived, tblAdverts.InvoiceRaised, 
    tblAdverts.NetRate, tblAdverts.NetRatePounds
FROM dbo.tblAdverts INNER JOIN
    dbo.tblAdPositions ON 
    dbo.tblAdverts.p_ad_id = dbo.tblAdPositions.p_adposition_id INNER
     JOIN
    dbo.tblBIGCompanies ON 
    dbo.tblAdverts.f_BIGCompany_id = dbo.tblBIGCompanies.p_company_id
     LEFT OUTER JOIN
    dbo.tblAdRep ON 
    dbo.tblAdverts.f_rep_id = dbo.tblAdRep.p_rep_id
GROUP BY dbo.tblAdverts.p_ad_id, 
    dbo.tblBIGCompanies.company_name, 
    dbo.tblAdverts.image_name, dbo.tblAdverts.website, 
    dbo.tblAdverts.date_end, dbo.tblAdverts.date_start, 
    dbo.tblAdverts.LastClicked, dbo.tblAdverts.NumberClicks, 
    dbo.tblAdverts.GrossRate, dbo.tblAdverts.NetRate, 
    dbo.tblAdverts.SignedOrderReceived, 
    dbo.tblAdverts.InvoiceRaised, dbo.tblAdPositions.f_adtype_id, 
    dbo.tblAdRep.forename + ' ' + dbo.tblAdRep.surname, 
    tblAdverts.NetRatePounds
HAVING (dbo.tblAdPositions.f_adtype_id = 3)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwUnionAdvertisers]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW [dbo].[vwUsers]
AS
SELECT     p_user_id, forename, surname, username, password, f_user_type_id
FROM         dbo.tblUsers


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT  SELECT  ON [dbo].[vwUsers]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[SpRemoveArticleImage]
(@ArticleID as INT)

As
BEGIN 

--- return compnay name to cf template
SELECT image
FROM   tblArticles
WHERE p_articles_id = @ArticleID  

----Remove image from row
UPDATE tblArticles
SET       image = ''
WHERE p_articles_id = @ArticleID 

END
return 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create PROCEDURE [dbo].dbo

( 
	@lstProductID varchar (50), 
	@ActivityID int, 
	@lstRegionID varchar (20)
)

AS

BEGIN

IF @lstProductID = '0'
	---run search based on activities
	SELECT  DISTINCT  A.p_company_id AS CompanyID, A.company_name, A.sort_order
	FROM   dbo.tblBIGProducts C 
		INNER JOIN dbo.tblBIGActivities D ON C.f_activity_id = D.p_activity_id 
		INNER JOIN dbo.tblBIGCompanies A 
		INNER JOIN dbo.tblBIGProductEntries B ON A.p_company_id = B.f_company_id ON 
	                      C.p_products_id = B.f_products_id
	WHERE 	C.f_activity_id = @ActivityID
	ORDER BY A.sort_order

ELSE

BEGIN
	
PRINT @lstRegionID
	IF @lstRegionID = '0'
		--search companies based on products
		SELECT DISTINCT A.p_company_id AS CompanyID, A.company_name, A.sort_order
		FROM         dbo.tblBIGCompanies A INNER JOIN
		                      dbo.tblBIGProductEntries B ON B.f_company_id = A.p_company_id 
		INNER JOIN (Select value From fn_ConvertToTable(@lstProductID))FN
			ON B.f_products_id = FN.value
		ORDER BY A.sort_order	

	ELSE
		--search companies based on products and regions
		SELECT DISTINCT A.p_company_id AS CompanyID, A.company_name, A.sort_order
		FROM         dbo.tblBIGCompanies A INNER JOIN
		                      dbo.tblBIGProductEntries B ON B.f_company_id = A.p_company_id INNER JOIN
		                      dbo.tblBIGRegionEntries C ON A.p_company_id = C.f_company_id
		INNER JOIN (Select value From fn_ConvertToTable(@lstProductID))FN
			ON B.f_products_id = FN.value
		INNER JOIN (Select value From fn_ConvertToTable(@lstRegionID))FN2
			ON C.f_region_id = FN2.value
		ORDER BY A.sort_order

END

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spAdvertiserLists]
As

BEGIN
--- return all adtypes	
SELECT p_AdType_id, ad_type 
FROM   tblAdTypes

--- Return ad reps
SELECT p_rep_id, forename + ' ' + surname AS RepName
FROM  tblAdRep

END

return 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spAutheticateClient]
(
	@Where as varchar (500) 
)

As
DECLARE @SQL as varchar(100)
/*Set @SQL to a hold SQL statement as a string*/
SET @SQL = 'SELECT forename, surname, f_user_type_id'
	
/* set nocount on */
	return

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spClient]
(@forename as varchar (50),
@surname as varchar(50))

As

IF EXISTS (SELECT *
		From tblUsers
		WHERE forename = @forename AND surname = @surname)
BEGIN
	SELECT *
	FROM tblUsers
	WHERE forename = @forename AND surname = @surname

	RETURN 0
END

ELSE 	

RETURN -1

/* set nocount on */
	return

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spDeleteArticle]
(@ArticleID as int)

As
---Delete a particualr article

DELETE
FROM  tblArticles
WHERE p_articles_id = @ArticleID
	
--Return a status of 0 to Coldfusion to indicate success
RETURN 0



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spGetArticle]
(
	@article_id INT
)

As
/* Return all details on a particular article */
SELECT p_articles_id AS article_id, headline_banner, story, byline, headline, author, image,
   	 date_posted, f_article_type_id AS article_type, f_IssueCode AS IssueCode, date_commence, image_caption
FROM dbo.tblArticles
WHERE	p_articles_id = @article_id 

return


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spGetCompanyDetails]
(@CompanyID AS INT)
AS
BEGIN
--- Return Company Details
	SELECT * 
	FROM vwCompanyDetails 
	WHERE CompanyID = @CompanyID	
--- Return Product Listing for this company
	 SELECT *
	 FROM vwProductListings
	 WHERE CompanyID = @CompanyID
	 ORDER BY product 
--- Return Region Entries fro this company
	 SELECT *
	 FROM vwRegionListings
	 WHERE CompanyID = @CompanyID
END
RETURN


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spGetContacts]
As
SELECT * FROM   tblContacts
ORDER by p_contact_id 	
return

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spGetCurrencies]
/*
	(
		@parameter1 datatype = default value,
		@parameter2 datatype OUTPUT
	)
*/
As
SELECT abbreviation + ' ' +  country as Currency, abbreviation, 
    sort_order
FROM tblCurrencies
ORDER BY sort_order DESC, country
	/* set nocount on */
	return 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertAdRep]
(	@forename as varchar, 
	@surname as varchar, 
	@area as varchar,
	@NewRepID as int = null OUTPUT)

As
---Insert Rep into table
INSERT INTO tblAdRep(forename, surname, area)
VALUES	(@forename, @surname, @area)

--Set output parameter to the ID of the newly inserted row
		SET @NewRepID = @@IDENTITY

--Return a status of 0 to Coldfusion to indicate success
		RETURN 0






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertArticle]
(	
	@headline_banner AS varchar (1000), 
	@story AS text, 
	@ArticleTypeID AS INT, 
	@headline AS varchar(1), 
	@byline AS varchar (1000),
	@IssueCode AS varchar (6),
	@DateCommencing AS datetime,
	@image_caption as varchar (1000),
	@NewArticleID AS INT = null OUTPUT
)

As
---Set local variable to hold today's date
DECLARE @DateToday AS Datetime
SELECT @DateToday = GetDate() 


 
-- Insert Article into table
BEGIN 
	INSERT INTO tblArticles (headline_banner, story, f_article_type_id, headline, byline, date_posted, f_IssueCode, date_commence, image_caption)
	VALUES (@headline_banner, 
		CONVERT(ntext, @Story), 
		@ArticleTypeID, 
		@headline, 
		@byline, 
		@DateToday,
		@IssueCode,
		@DateCommencing,
		@image_caption)


--Set output parameter called @NewArtilceID to the ID of the newly inserted Article
		SET @NewArticleID = @@IDENTITY

--Return a status of 0 to Coldfusion to indicate success
		RETURN 0

END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertContact]
(	@forename as varchar (50),
	@surname as varchar (50),
	@tel as varchar (100),
	@email as varchar (100),
	@job as varchar (150),
	@NewContactID AS INT = null OUTPUT
)

As
--- Insert Contact into table
BEGIN 
	INSERT INTO tblContacts(forename, surname, tel, email, job_title)
	VALUES (@forename, @surname, @tel, @email, @job)

--Set output parameter called @NewContactID to the ID of the newly inserted Contact
		SET @NewContactID = @@IDENTITY

--Return a status of 0 to Coldfusion to indicate success
		RETURN 0

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertCountries]
As

INSERT into tblCountries(country)
SELECT dbo.AdditionalCountries.Field1 
   		FROM dbo.tblCountries RIGHT OUTER JOIN
   		 dbo.AdditionalCountries ON 
   		 dbo.tblCountries.country = dbo.AdditionalCountries.Field1
WHERE (dbo.tblCountries.country IS NULL)

return



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertEmployer]
(
	@CompanyName as varchar (50),
	@address1 as varchar (50),
	@address2 as varchar (50),
	@address3 as varchar (100),
	@town as varchar (100),
	@county as varchar (50),
	@CountryID as int,
	@website as varchar (100),
	@username as varchar (50),
	@password as varchar (50),
	@active as int,
	@ServiceID as int,
	@SubStart as datetime,
	@SubEnd as datetime,
	@SalutationID as int,
	@forename as varchar (50),
	@surname as varchar (50),	
	@JobTitle as varchar (150),
	@email as varchar (50),
	@NewEmployerID as INT = null OUTPUT
)

As
--- Insert new employer
INSERT INTO tblEmployers (company_name, address1, address2, address3, town, county, f_country_id, website, username, password, active_sub,
	f_service_id, subscription_date, subscription_date_end, f_salutation_id, forename, surname, job_title, email)
VALUES (@CompanyName, @address1, @address2,@address3,@town, @county, @CountryID, @website, @username, @password, @active,
	@ServiceID, @SubStart, @SubEnd, @SalutationID,@forename,@surname,@JobTitle, @email)

--Set output parameter called @NewArtilceID to the ID of the newly inserted Article
		SET @NewEmployerID = @@IDENTITY

--Return a status of 0 to Coldfusion to indicate success
		RETURN 0


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertEvent]

(	
	@event_name as varchar(250), 
	@organiser as varchar(100), 
	@date_start as datetime, 
	@date_end as datetime, 
    	@VenueName as varchar(100), 
	@VenueAddress1 as varchar(50), 
	@VenueAddress2 as varchar(50), 
    	@VenueAddress3 as varchar(100), 
	@town as varchar(50), 
	@county as varchar(50), 
	@f_country_id as int, 
	@tel as varchar(50), 
	@fax as varchar(50), 
	@email as varchar(100), 
    	@website as varchar(100), 
	@contact_forename as varchar(50), 
	@contact_surname as varchar(50), 
	@contact_tel as varchar(50), 
    	@contact_fax as varchar(50), 
	@paper_calls_forename as varchar(50),
	@paper_calls_surname as varchar(50), 
    	@paper_calls_tel as varchar(50), 
	@paper_calls_fax as varchar(50), 
	@paper_calls_email as varchar(100), 
    	@contact_saluationID as int, 
	@contact_email as varchar(100), 
	@paper_calls_saluationID as int, 
    	@paper_call as int, 
	@detail as varchar (2000),
	@paper_call_detail as varchar (2000),
	@paper_call_deadline as datetime,
	@NewEventID as int = null OUTPUT
)

As
--- Insert Event into table
BEGIN 
	INSERT INTO tblEvents (event_name, organiser, date_start, date_end, 
   	 venue_name, venue_address1, venue_address2, 
    	venue_address3, town, county, f_country_id, tel, fax, email, 
    	website, contact_forename, contact_surname, contact_tel, 
    	contact_fax, paper_calls_forename, paper_calls_surname, 
    	paper_calls_tel, paper_calls_fax, paper_calls_email, 
    	contact_salutationID, contact_email, paper_calls_salutationID, 
    	paper_call, detail, paper_call_detail, paper_call_deadline)
	VALUES (@event_name, @organiser, @date_start, @date_end, @VenueName, @VenueAddress1, @VenueAddress2, @VenueAddress3, @town, 
	@county, @f_country_id, @tel, @fax, @email, @website, @contact_forename, @contact_surname, @contact_tel, @contact_fax, 
	@paper_calls_forename,@paper_calls_surname, @paper_calls_tel, @paper_calls_fax, @paper_calls_email, @contact_saluationID, @contact_email, 
	@paper_calls_saluationID, @paper_call, @detail, @paper_call_detail, @paper_call_deadline)

--Set output parameter called @NewEventID to the ID of the newly inserted Event
		SET @NewEventID = @@IDENTITY

--Return a status of 0 to Coldfusion to indicate success
		RETURN 0

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertJob]
(
	@EmployerID as int,
	@Job_Title as varchar (100),
	@description as text,
	@experince as text,
	@package as text,
	@status as int,	
	@application_method as varchar(50),
	@salary as money,
	@application_deadline as datetime,
	@SalutationID as int,
	@forename as varchar(50),
	@surname as varchar(50),
	@position as varchar(50),
	@tel as varchar(50),
	@fax as varchar(50), 	
	@email as varchar(100), 
	@ContractID as int,
	@SalaryRangeID as int,	 	
	@NewJobID as int = null OUTPUT
)

As
---Set local variable to hold today's date
DECLARE @DateToday AS Datetime
SELECT @DateToday = GetDate() 

---Insert Job into table
BEGIN
	INSERT INTO tblJobs (f_employer_id, job_title, description, experience, [package], application_method, 
		salary_per_annum, application_deadline, f_salutation_id, forename, 
		surname, [position], tel, fax, email, f_salary_range_id, f_contract_id, status, date_posted)
	VALUES (@EmployerID, @Job_Title, CONVERT(ntext, @description), CONVERT(ntext, @experince),  CONVERT(ntext, @package), @application_method, @salary, 
		@application_deadline, @SalutationID, @forename, @surname, @position, @tel,
	 	@fax, @email, @status,	@ContractID, @SalaryRangeID, @DateToday)
	
	
--Set output parameter called @NewArtilceID to the ID of the newly inserted Article
		SET @NewJobID = @@IDENTITY

--Return a status of 0 to Coldfusion to indicate success
		RETURN 0

END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertJobSeeker]
(
	@forename as varchar (50),
	@surname as varchar (50),
	@email as varchar (100),
	@password as varchar (50),
	@HTML as bit,
	@NewJobSeekerID INT = null OUTPUT
)


AS
--- Make sure the client has not already become a jobseeker

IF EXISTS 
	(SELECT *
	FROM tblJobseekers
	WHERE email = @email)
--- If specified already return status code to ColdFusion
	RETURN -1

--- if email not in database then perform insert
ELSE
	BEGIN
		INSERT INTO tblJobseekers (forename, surname, email, password, receive_email, receive_html)
		VALUES (@forename, @surname, @email, @password, 1, @HTML ) 

---Set output parameter called @NewFilmID to the ID of the just inserted jobseeker
		SET @NewJobSeekerID = @@IDENTITY

---Return a status of 1 to Coldfusin to indicate success
		RETURN 1

END
 



 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertLink]
(	@title as varchar (150),
	@WebAddress as varchar (100),
	@NewLinkID AS INT = null OUTPUT
)

As
--- Insert Article into table
BEGIN 
	INSERT INTO tblLinks (title, WebAddress)
	VALUES (@title, @WebAddress)

--Set output parameter called @NewArtilceID to the ID of the newly inserted Article
		SET @NewLinkID = @@IDENTITY

--Return a status of 0 to Coldfusion to indicate success
		RETURN 0

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertProjectLink]
 
(	@project as varchar (150),
	@WebAddress as varchar (100),
	@comments as varchar (2000),
	@AreaID as int,
	@NewLinkID as int = null OUTPUT
)

As
--- Insert Article into table
BEGIN 
	INSERT INTO tblProjectLinks (project, WebAddress, comments, f_area_id)
	VALUES (@project, @WebAddress, @comments, @AreaID)

--Set output parameter called @NewArtilceID to the ID of the newly inserted Article
		SET @NewLinkID = @@IDENTITY

--Return a status of 0 to Coldfusion to indicate success
		RETURN 0

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spInsertTempBGUser]
(	
	@SaluationID as INT,
	@forename as varchar (50),
	@surname as varchar (50),
	@address1 as varchar (100),
	@address2 as varchar (100),
	@address3 as varchar (150),
	@town as varchar (50),
	@county as varchar (50),
	@postcode as varchar (50),
	@countryID as int,
	@tel as varchar (50),
	@username as varchar (50),
	@password as varchar (50),
	@marketingSup as bit,
	@NewBGUserID INT = null OUTPUT
)

AS
--- Check that email address is unique
IF EXISTS 
	(SELECT username
	FROM tblUsers
	WHERE username = @username)
--- If specified already return status code to ColdFusion
	RETURN -1

--- If email not in database then perform insert
ELSE
	BEGIN
		INSERT INTO tblUsers(f_salutation_id, forename, surname, address1, address2, address3, town, county, 
				postcode, f_country_id, tel, username, password, marketingsupress, f_user_type_id)
		VALUES (@SaluationID, @forename, @surname, @address1, @address2, @address3, @town, @county, @postcode,
				@countryID, @tel, @username, @password, @marketingSup, 3)

--- Set output parameter called NewClientID to the ID of the just inserted user
		SET @NewBGUserID = @@IDENTITY

--- Return a status of 1 to Coldfusin to indicate success
		RETURN 1

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spJobLists]
---Run all quries need to make cfm job search template
As

BEGIN	

---return countries
SELECT *
FROM vwCountries 
	
---return positions
SELECT *
FROM   vwPositions

---return languages
SELECT *
FROM   vwLanguages

---return Contract types
SELECT *
FROM   vwContracts

---return Salutations
SELECT *
FROM   vwSalutations

END

return 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spListArticles]
(
	@type INT
)
As
/* Return all atricles of a specfic type */
SELECT p_articles_id AS article_id, headline_banner, f_article_type_id AS article_type, headline, f_IssueCode,
    date_posted, date_commence
FROM dbo.tblArticles
WHERE f_article_type_id = @type
ORDER by date_posted DESC 
	

return


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [dbo].[spSearchBIGCoNames]

(
	@Company varchar (50),
	@Operator int

)

 AS

IF @Operator = 1
 
 SELECT p_company_id AS CompanyID, company_name
 FROM dbo.tblBIGCompanies
 WHERE  company_name LIKE @company + '%'
 ORDER BY sort_order

ELSE IF @Operator = 2

 SELECT p_company_id AS CompanyID, company_name
 FROM dbo.tblBIGCompanies
 WHERE  company_name LIKE '%' + @company + '%'
 ORDER BY sort_order

ELSE IF @Operator = 3
 
 SELECT p_company_id AS CompanyID, company_name
 FROM dbo.tblBIGCompanies
 WHERE  company_name = @company
 ORDER BY sort_order
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].spSearchBIGCompanies

( 
	@lstProductID varchar (50), 
	@ActivityID int, 
	@lstRegionID varchar (20)
)

AS

BEGIN

IF @lstProductID = '0'
	---run search based on activities
	SELECT  DISTINCT  A.p_company_id AS CompanyID, A.company_name, A.sort_order
	FROM   dbo.tblBIGProducts C 
		INNER JOIN dbo.tblBIGActivities D ON C.f_activity_id = D.p_activity_id 
		INNER JOIN dbo.tblBIGCompanies A 
		INNER JOIN dbo.tblBIGProductEntries B ON A.p_company_id = B.f_company_id ON 
	                      C.p_products_id = B.f_products_id
	WHERE 	C.f_activity_id = @ActivityID
	ORDER BY A.sort_order

ELSE

BEGIN
	
PRINT @lstRegionID
	IF @lstRegionID = '0'
		--search companies based on products
		SELECT DISTINCT A.p_company_id AS CompanyID, A.company_name, A.sort_order
		FROM         dbo.tblBIGCompanies A INNER JOIN
		                      dbo.tblBIGProductEntries B ON B.f_company_id = A.p_company_id 
		INNER JOIN (Select value From fn_ConvertToTable(@lstProductID))FN
			ON B.f_products_id = FN.value
		ORDER BY A.sort_order	

	ELSE
		--search companies based on products and regions
		SELECT DISTINCT A.p_company_id AS CompanyID, A.company_name, A.sort_order
		FROM         dbo.tblBIGCompanies A INNER JOIN
		                      dbo.tblBIGProductEntries B ON B.f_company_id = A.p_company_id INNER JOIN
		                      dbo.tblBIGRegionEntries C ON A.p_company_id = C.f_company_id
		INNER JOIN (Select value From fn_ConvertToTable(@lstProductID))FN
			ON B.f_products_id = FN.value
		INNER JOIN (Select value From fn_ConvertToTable(@lstRegionID))FN2
			ON C.f_region_id = FN2.value
		ORDER BY A.sort_order

END

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spSetAdDate]
As
DECLARE @DateToday as datetime 
SET @DateToday = GetDate() 
      
---- Update advertisers details to conatin correct ad time	
UPDATE tblBIGCompanies
SET AdStartDate = @DateToday,
     AdEndDate = DateAdd(yy, 1, @DateToday)	 	
WHERE advertiser = 1
/* set nocount on */
	return

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spUpdateAdClick]
(@AdID as int)

As

--- update numer of clicks for a specific ad	
UPDATE tblAdverts
SET 	LastClicked = getdate(),
            NumberClicks = NumberClicks + 1
WHERE p_ad_id = @AdID 	 
	
return 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[spUploadData]
As
	
INSERT INTO tblArticles (headline_banner, story, f_IssueCode)
SELECT headline_banner, story, f_IssueCode
FROM ex

UPDATE tblArticles 
SET f_article_type_id = 2, headline = 'n'
WHERE f_article_type_id IS NULL

/* set nocount on */
	return 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

