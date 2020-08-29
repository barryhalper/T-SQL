/*
Date            Author                    Action
------------------------------------------------------------------
2006-08-02    Malcolm Collins    The procedure has been supplemented to show the 
                                                60 charcters around the 'Text To Find' string within the 
                                                column so that you can see the context
*/

DECLARE @TextToFind VARCHAR(100)
SET @TextToFind = 'your text'
select so.name, 
sc.text,
SUBSTRING(sc.text,CHARINDEX(@TextToFind,sc.text) - 30,60) AS Incidence
from syscomments sc
inner join sysobjects so
on sc.id = so.id
where xtype = 'p'
and so.category = 0
and text like '%' + @TextToFind + '%'