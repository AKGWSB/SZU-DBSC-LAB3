use lab3;
drop procedure if exists insert_employee;

delimiter //
create procedure insert_employee(
    in _eid int,
    in _ename varchar(15),
    in _city varchar(15)
)
insert_employee:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(32) default "query fail";

    # 检查是否存在 eid 相同的记录
    select count(eid) from employees where eid=_eid limit 1 into res;
    if res>0 then
        set msg = "employee already exists!";
        select st, msg;
        leave insert_employee;
    end if;

    # 执行插入语句
    insert into employees
    (`eid`, `ename`, `city`)
    values
    (_eid, _ename, _city);

    # 返回成功
    set st = 1;
    set msg = "insert employee success!";
    select st, msg;
end//
delimiter ;
