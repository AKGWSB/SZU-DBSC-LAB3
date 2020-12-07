use lab3;
drop procedure if exists show_employees;

delimiter //
create procedure show_employees()
begin
    select * from employees;
end //
delimiter ;
