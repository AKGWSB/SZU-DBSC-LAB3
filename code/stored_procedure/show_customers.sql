use lab3;
drop procedure if exists show_customers;

delimiter //
create procedure show_customers()
begin
    select * from customers;
end //
delimiter ;
