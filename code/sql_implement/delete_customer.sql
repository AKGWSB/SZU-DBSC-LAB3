use lab3;
drop procedure if exists delete_customer;

delimiter //
create procedure delete_customer(in _cid int)
delete_customer:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(32) default "query fail";

    # 检查是否存在 cid 相同的记录
    select count(cid) from customers where cid=_cid limit 1 into res;
    if res<1 then
        set msg = "target customer not exists!";
        select st, msg;
        leave delete_customer;
    end if;

    # 检查 cid 是否存在外键约束
    select count(customers.cid) from customers, purchases
    where customers.cid=_cid and customers.cid=purchases.cid
    limit 1 into res;
    if res>0 then
        set msg = "exists foreign key <cid> limit";
        select st, msg;
        leave delete_customer;
    end if;

    # 执行删除语句
    delete from customers where cid=_cid;

    # 返回成功
    set st = 1;
    set msg = "delete customer success!";
    select st, msg;
end//
delimiter ;
