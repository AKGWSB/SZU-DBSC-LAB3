use lab3;
drop procedure if exists delete_employee;

delimiter //
create procedure delete_employee(in _eid int)
delete_employee:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(32) default "query fail";

    # 检查是否存在 eid 相同的记录
    select count(eid) from employees where eid=_eid limit 1 into res;
    if res<1 then
        set msg = "target employee not exists!";
        select st, msg;
        leave delete_employee;
    end if;

    # 检查是否存在外键约束
    select count(employees.eid) from employees, purchases
    where employees.eid=_eid and employees.eid=purchases.eid
    limit 1 into res;
    if res>0 then
        set msg = "exists foreign key <eid> limit";
        select st, msg;
        leave delete_employee;
    end if;

    # 执行删除语句
    delete from employees where eid=_eid;

    # 返回成功
    set st = 1;
    set msg = "delete employee success!";
    select st, msg;
end//
delimiter ;
