use lab3;
drop procedure if exists show_purchases;

delimiter //
create procedure show_purchases()
begin
    select * from purchases order by pur desc;
end //
delimiter ;
