

SELECT * FROM dbo.tblAdvert

SELECT R.* 
FROM  trelAdvertOrderItem R 
 INNER JOIN tlkpSection S
  ON R.intSection = S.intSectioncnt
WHERE S.strFormat = 'Website'


SELECT * FROM  dbo.tlkpSection