use lab3;
drop procedure if exists delete_supplier;

delimiter //
create procedure delete_supplier(in _sid int)
delete_supplier:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(32) default "query fail";

    # 检查是否存在 sid 相同的记录
    select count(sid) from suppliers where sid=_sid limit 1 into res;
    if res<1 then
        set msg = "target supplier not exists!";
        select st, msg;
        leave delete_supplier;
    end if;

    # 检查外键约束
    select count(suppliers.sid) from suppliers, products
    where suppliers.sid=_sid and suppliers.sid=products.sid
    limit 1 into res;
    if res>0 then
        set msg = "exists foreign key <sid> limit";
        select st, msg;
        leave delete_supplier;
    end if;

    # 执行删除语句
    delete from suppliers where sid=_sid;

    # 返回成功
    set st = 1;
    set msg = "delete supplier success!";
    select st, msg;
end//
delimiter ;
