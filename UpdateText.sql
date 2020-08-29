/*TEXT TO FIND in BLOB*/
 declare @otxt varchar(100)
 set @otxt = 'http://192.168.1.61/his_localgov/'

DECLARE CURS CURSOR LOCAL FAST_FORWARD
FOR

SELECT p_news_id, 
	textptr(story),
	charindex(@otxt, story)-1
FROM    tblnews
WHERE  charindex('http://192.168.1.61/his_localgov/', story) <> 0


/**text to replace in BLOB**/
declare @ntxt varchar(50)
set @ntxt = ''

declare @txtlen int
set 	@txtlen = len(@otxt)

declare @ptr binary(16)
declare @pos int
declare @id int

open curs

fetch next from curs into @id, @ptr, @pos

while @@fetch_status = 0 
begin	
	UPDATETEXT tblnews.story @ptr @pos @txtlen @ntxt

	fetch next from curs into @id, @ptr, @pos	
end

close curs
deallocate curs

SELECT COUNT(*)
FROM     tblnews
WHERE  charindex('http://192.168.1.61/his_localgov/', story) <> 0