use lab3;
drop procedure if exists update_supplier;

delimiter //
create procedure update_supplier(
    in _sid int,
    in _sname varchar(15),
    in _city varchar(15),
    in _telephone_no char(10)
)
update_supplier:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(32) default "query fail";

    # 检查是否存在 sid 相同的记录
    select count(sid) from suppliers where sid=_sid limit 1 into res;
    if res<1 then
        set msg = "target supplier not exists!";
        select st, msg;
        leave update_supplier;
    end if;

    # 检查是否存在 sname 相同的不同记录
    select count(sid) from suppliers where sname=_sname and sid!=_sid limit 1 into res;
    if res>0 then
        set msg = "supplier name already exists!";
        select st, msg;
        leave update_supplier;
    end if;

    # 执行更新语句
    update suppliers set
        sname = _sname,
        city = _city,
        telephone_no = _telephone_no
    where sid=_sid;

    # 返回成功
    set st = 1;
    set msg = "update supplier success!";
    select st, msg;
end//
delimiter ;
