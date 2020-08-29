/************************************************\
SP: sp_GetGroupDetails
DESCRIPTION:
Group details. Filter on GroupID if provided.
Restrict records on region code.
 
HISTORY:
Date:                   Author:             Description:
2005-01-27     Iain Turbitt        Created
2005-02-06     Iain Turbitt        Added additional parameters for searching on: @GroupName, @Information and keyords
 
\************************************************/
 
CREATE PROCEDURE dbo.sp_GetGroupDetails
@GroupID   INT   = NULL,
@EventInstanceID  INT,
@LstRegionCodes  VARCHAR(25),
@GroupName   VARCHAR(255)  = NULL,
@Keyword   VARCHAR(100)  = NULL,
@VerticalKeywordID INT   = NULL,
@HorizontalKeywordID  INT   = NULL,
@Information   VARCHAR(2000)  = NULL
 
AS
SET NOCOUNT ON
 
SELECT  G.GroupID,
  G.GroupName,
  G.Keyword,
  G.RegionCode,
  G.Information,
  G.VerticalKeywordID,
  G.HorizontalKeywordID,
  VGK.Keyword AS VerticalKeyword,
  HGK.Keyword AS HorizontalKeyword,
  R.RegionName,
  (
  SELECT  COUNT(GroupID)
  FROM  PAPERGROUP PG
  WHERE  PG.GroupID = G.GroupID
  ) AS numberOfPapers
FROM [GROUP] G
INNER JOIN REGION R
 ON G.RegionCode = R.RegionCode
INNER JOIN (
  SELECT *
  FROM  fn_ConvertToTable_Vars(@LstRegionCodes)
  ) AS tbl_RegionCodes
 ON G.RegionCode = Value
LEFT OUTER JOIN GROUPKEYWORD VGK
 ON G.VerticalKeywordID = VGK.GroupKeywordID
LEFT OUTER JOIN GROUPKEYWORD HGK
 ON G.HorizontalKeywordID = HGK.GroupKeywordID
WHERE  G.EventInstanceID  = @EventInstanceID
 AND G.GroupID   = IsNull(@GroupID, G.GroupID)
 AND G.GroupName   LIKE IsNull('%'+@GroupName+'%', G.GroupName)
 AND G.Keyword   LIKE IsNull('%'+@Keyword +'%', G.Keyword)
 AND G.Information   LIKE IsNull('%'+@Information +'%', G.Information)
 AND G.VerticalKeywordID  = IsNull(@VerticalKeywordID, G.VerticalKeywordID)
 AND G.HorizontalKeywordID = IsNull(@HorizontalKeywordID, G.HorizontalKeywordID)
ORDER BY G.GroupName, VGK.Keyword, HGK.Keyword
 
 
 
GO

 
