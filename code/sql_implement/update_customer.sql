use lab3;
drop procedure if exists update_customer;

delimiter //
create procedure update_customer(
    in _cid int,
    in _cname varchar(15),
    in _city varchar(15),
    in _visits_made int,
    in _last_visit_time datetime
)
update_customer:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(32) default "query fail";

    # 检查是否存在 cid 相同的记录
    select count(cid) from customers where cid=_cid limit 1 into res;
    if res<1 then
        set msg = "target customer not exists!";
        select st, msg;
        leave update_customer;
    end if;

    # 执行更新语句
    update customers set 
        cname = _cname,
        city = _city,
        visits_made = _visits_made,
        last_visit_time = _last_visit_time
    where cid=_cid;

    # 返回成功
    set st = 1;
    set msg = "update customer success!";
    select st, msg;
end//
delimiter ;
