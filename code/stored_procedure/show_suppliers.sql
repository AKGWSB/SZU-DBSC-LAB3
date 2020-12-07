use lab3;
drop procedure if exists show_suppliers;

delimiter //
create procedure show_suppliers()
begin
    select * from suppliers;
end //
delimiter ;
