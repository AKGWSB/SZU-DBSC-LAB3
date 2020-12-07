use lab3;
drop procedure if exists insert_supplier;

delimiter //
create procedure insert_supplier(
    in _sid int,
    in _sname varchar(15),
    in _city varchar(15),
    in _telephone_no char(10)
)
insert_supplier:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(32) default "query fail";

    # 检查是否存在 eid 相同的记录
    select count(sid) from suppliers where sid=_sid or sname=_sname limit 1 into res;
    if res>0 then
        set msg = "supplier already exists!";
        select st, msg;
        leave insert_supplier;
    end if;

    # 执行插入语句
    insert into suppliers
    (`sid`, `sname`, `city`, `telephone_no`)
    values
    (_sid, _sname, _city, _telephone_no);

    # 返回成功
    set st = 1;
    set msg = "insert supplier success!";
    select st, msg;
end//
delimiter ;
