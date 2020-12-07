use lab3;
drop procedure if exists report_monthly_sale;

delimiter //
create procedure report_monthly_sale(in p_id int)
begin
    select 
        products.pname, 
        SUBSTR(DATE_FORMAT(purchases.ptime, "%M"), 1, 3),
        DATE_FORMAT(purchases.ptime, "%Y"),
        SUM(qty),
        SUM(total_price),
        SUM(total_price)/SUM(qty)
    from products, purchases
    where products.pid=p_id and products.pid=purchases.pid
    group by DATE_FORMAT(purchases.ptime, "%Y"), DATE_FORMAT(purchases.ptime, "%m");
end//
delimiter ;