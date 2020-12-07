use lab3;
drop procedure if exists delete_purchase;

delimiter //
create procedure delete_purchase(in _pur int)
delete_purchase:
begin
    declare st, res int default 0;
    declare msg varchar(64) default "query fail";

    # 检查是否存在记录
    select count(pur) from purchases where pur=_pur limit 1 into res;
    if res<1 then
        set msg = "target purchase not exists!";
        select st, msg;
        leave delete_purchase;
    end if;

    # 执行删除语句
    delete from purchases where pur=_pur;

    # 返回成功
    set st = 1;
    set msg = "delete purchase success!";
    select st, msg;
end//
delimiter ;
