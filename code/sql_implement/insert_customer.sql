use lab3;
drop procedure if exists insert_customer;

delimiter //
create procedure insert_customer(
    in _cid int,
    in _cname varchar(15),
    in _city varchar(15),
    in _visit_made int,
    in _last_visit_time datetime
)
insert_customer:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(32) default "query fail";

    # 检查是否存在 cid 相同的记录
    select count(cid) from customers where cid=_cid limit 1 into res;
    if res>0 then
        set msg = "customer already exists!";
        select st, msg;
        leave insert_customer;
    end if;

    # 执行插入语句
    insert into customers
    (`cid`, `cname`, `city`, `visits_made`, `last_visit_time`)
    values
    (_cid, _cname, _city, _visit_made, _last_visit_time);

    # 返回成功
    set st = 1;
    set msg = "insert customer success!";
    select st, msg;
end//
delimiter ;
