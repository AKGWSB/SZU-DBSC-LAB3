use lab3;
drop procedure if exists delete_product;

delimiter //
create procedure delete_product(in _pid int)
delete_product:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(64) default "query fail";

    # 检查是否存在 pid 相同的记录
    select count(pid) from products where pid=_pid limit 1 into res;
    if res<1 then
        set msg = "target product not exists!";
        select st, msg;
        leave delete_product;
    end if;

    # 检查外键约束 购买记录 purchases 如果有依赖则不能删除
    select count(products.pid) from products, purchases 
    where products.pid=_pid and products.pid=purchases.pid
    limit 1 into res;
    if res>0 then
        set msg = "foreign key <pid> limit: a record exists in table <purchases>!";
        select st, msg;
        leave delete_product;
    end if;

    # 执行删除语句
    delete from products where pid=_pid;

    # 返回成功
    set st = 1;
    set msg = "delete product success!";
    select st, msg;
end//
delimiter ;
