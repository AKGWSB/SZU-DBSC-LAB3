use lab3;
drop procedure if exists update_purchase;

delimiter //
create procedure update_purchase(
    in _pur int,
    in _cid int,
    in _eid int,
    in _pid int,
    in _qty int,
    in _ptime datetime,
    in _total_price decimal(7,2)
)
update_purchase:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(64) default "query fail";

    # 检查是否存在记录
    select count(pur) from purchases where pur=_pur limit 1 into res;
    if res<1 then
        set msg = "target purchase not exists!";
        select st, msg;
        leave update_purchase;
    end if;

    # 验证 cid 是否存在
    select count(cid) from customers where cid=_cid limit 1 into res;
    if res<1 then
        set msg = "foreign key <cid> limit: customer not found!";
        select st, msg;
        leave update_purchase;
    end if;

    # 验证 eid 是否存在
    select count(eid) from employees where eid=_eid limit 1 into res;
    if res<1 then
        set msg = "foreign key <eid> limit: employee not found!";
        select st, msg;
        leave update_purchase;
    end if;

    # 验证 pid 是否存在
    select count(pid) from products where pid=_pid limit 1 into res;
    if res<1 then
        set msg = "foreign key <pid> limit: product not found!";
        select st, msg;
        leave update_purchase;
    end if;

    # 执行更新
    update purchases set
        cid=_cid,
        eid=_eid,
        pid=_pid,
        qty=_qty,
        ptime=_ptime,
        total_price=_total_price
    where pur=_pur;

    # 返回成功
    set st = 1;
    set msg = "update purchase success!";
    select st, msg;
end//
delimiter ;
