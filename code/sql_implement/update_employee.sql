use lab3;
drop procedure if exists update_employee;

delimiter //
create procedure update_employee(
    in _eid int,
    in _ename varchar(15),
    in _city varchar(15)
)
update_employee:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(32) default "query fail";

    # 检查是否存在 eid 相同的记录
    select count(eid) from employees where eid=_eid limit 1 into res;
    if res<1 then
        set msg = "target employee not exists!";
        select st, msg;
        leave update_employee;
    end if;

    # 执行更新语句
    update employees set
        ename = _ename,
        city = _city
    where eid=_eid;

    # 返回成功
    set st = 1;
    set msg = "update employee success!";
    select st, msg;
end//
delimiter ;
