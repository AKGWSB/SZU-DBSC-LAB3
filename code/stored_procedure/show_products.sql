use lab3;
drop procedure if exists show_products;

delimiter //
create procedure show_products()
begin
    select * from products;
end //
delimiter ;
