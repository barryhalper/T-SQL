/*IF @columnlist is not null
 begin
   SELECT @columnlist= COALESCE(@columnlist + ', ', '') + 
   CAST(keyname AS varchar(100))
   FROM OPENXML (@idoc, '/root/structure',1)
   WITH (keyname varchar(150))

  SELECT @columnlist
 end  */