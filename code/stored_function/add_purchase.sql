use lab3;
drop procedure if exists add_purchase;

delimiter //
create procedure add_purchase(
    in c_id int,
    in e_id int,
    in p_id int,
    in pur_qty int
)
add_purchase:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(32) default "query fail";

    # 验证 cid 是否存在
    select count(cid) from customers where cid=c_id limit 1 into res;
    if res<1 then
        set msg = "customer not found!";
        select st, msg;
        leave add_purchase;
    end if;

    # 验证 eid 是否存在
    select count(eid) from employees where eid=e_id limit 1 into res;
    if res<1 then
        set msg = "employee not found!";
        select st, msg;
        leave add_purchase;
    end if;

    # 验证 pid 是否存在
    select count(pid) from products where pid=p_id limit 1 into res;
    if res<1 then
        set msg = "product not found!";
        select st, msg;
        leave add_purchase;
    end if;

    # 验证 pur_qty 是否超出 qoh
    select qoh from products where pid=p_id into res;
    if res<pur_qty then
        set msg = "purchase quantity out of limit!";
        select st, msg;
        leave add_purchase;
    end if;
    
    # 获取总价格
    select original_price*discnt_rate from products where pid=p_id into res;
    set res = res*pur_qty;

    # 增加记录到 purchases 表
    insert into purchases (cid, eid, pid, qty, ptime, total_price) values (c_id, e_id, p_id, pur_qty, now(), res);

    # 返回成功
    set st = 1;
    set msg = "add purchase success!";
    select st, msg;
end//
delimiter ;
