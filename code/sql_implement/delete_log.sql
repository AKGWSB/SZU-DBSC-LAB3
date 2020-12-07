use lab3;
drop procedure if exists delete_log;

delimiter //
create procedure delete_log(in _logid int)
delete_log:
begin
    declare st, res int default 0;
    declare msg varchar(64) default "query fail";

    # 检查是否存在记录
    select count(logid) from logs where logid=_logid limit 1 into res;
    if res<1 then
        set msg = "target log not exists!";
        select st, msg;
        leave delete_log;
    end if;

    # 执行删除语句
    delete from logs where logid=_logid;

    # 返回成功
    set st = 1;
    set msg = "delete log success!";
    select st, msg;
end//
delimiter ;
