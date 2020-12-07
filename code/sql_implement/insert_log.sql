use lab3;
drop procedure if exists insert_log;

delimiter //
create procedure insert_log(
    in _logid int,
    in _who varchar(10),
    in _time datetime,
    in _table_name varchar(20),
    in _operation varchar(6),
    in _key_value int
)
insert_log:
begin
    # 不支持直接插入
    declare st, res int default 0;
    declare msg varchar(64) default "query fail: logs not support insert directly!";
    select st, msg;
end//
delimiter ;
