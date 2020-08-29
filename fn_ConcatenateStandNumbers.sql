create function fn_ConcatenateStandNumbers (@OrderID int)
returns varchar(40)
as
/* JG 28.02.06 takes an OrderID and concatenates the related Stand Number(s) into a comma (& space) separated string
(each Order may have more than one OrderDetail line & hence more than one associated Stand Number)*/
begin
	declare @StandNo varchar(20)
	
	select @StandNo = COALESCE(@StandNo + ', ', '') + StandNumber
	from sales_db_live.dbo.tblorderdetails
	where f_order_id = @OrderID
	order by p_orderdetail_id

	return @StandNo
end