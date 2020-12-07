use lab3;
drop procedure if exists update_log;

delimiter //
create procedure update_log(
    in _logid int,
    in _who varchar(10),
    in _time datetime,
    in _table_name varchar(20),
    in _operation varchar(6),
    in _key_value int
)
update_log:
begin
    # 不支持直接修改
    declare st, res int default 0;
    declare msg varchar(64) default "query fail: logs not support update directly!";
    select st, msg;
end//
delimiter ;
