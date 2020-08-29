DECLARE @HitDay datetime
SET @HitDay = '01/23/2005'

---No of hits per day
SELECT COUNT (*) as TotalHits
FROM tblfusebox_Logs
WHERE Convert(char(10),hitdate,103)=Convert(Char(10),@HitDay,103)

--total users No of hits per day
SELECT COUNT (*), Totalusers, cftoken
FROM tblfusebox_Logs
GROUP BY cftoken, Convert(char(10),hitdate,103)
HAVING Convert(char(10),hitdate,103)=Convert(Char(10),@HitDay,103)

--No of hits per week
SELECT COUNT (*)
FROM tblfusebox_Logs
WHERE Convert(char(10),hitdate,103)=Convert(Char(10),@HitDay,103)

DECLARE @ThisweekStart Datetime
SET  @ThisweekStart =   GetDate() - 7


---No of hits This week
SELECT COUNT (*) as TotalHits
FROM tblfusebox_Logs
WHERE Hitdate  > =  @ThisweekStart


