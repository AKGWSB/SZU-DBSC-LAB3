use lab3;
drop procedure if exists show_logs;

delimiter //
create procedure show_logs()
begin
    select * from logs order by logid desc;
end //
delimiter ;
