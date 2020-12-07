use lab3;
drop procedure if exists update_product;

delimiter //
create procedure update_product(
    in _pid int,
    in _pname varchar(15),
    in _qoh int,
    in _qoh_threshold int,
    in _original_price decimal(6,2),
    in _discnt_rate decimal(3,2),
    in _sid int
)
update_product:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(64) default "query fail";

    # 检查是否存在 pid 相同的记录
    select count(pid) from products where pid=_pid limit 1 into res;
    if res<1 then
        set msg = "target product not exists!";
        select st, msg;
        leave update_product;
    end if;

    # 检查外键约束 没有对应的 supplier 则报错
    select count(sid) from suppliers where sid=_sid limit 1 into res;
    if res<1 then
        set msg = "foreign key <sid> limit: record not exists in table <suppliers>!";
        select st, msg;
        leave update_product;
    end if;

    # 执行更新语句
    update products set
        pname = _pname,
        qoh = _qoh,
        qoh_threshold = _qoh_threshold,
        original_price = _original_price,
        discnt_rate = _discnt_rate,
        sid = _sid
    where pid=_pid;

    # 返回成功
    set st = 1;
    set msg = "update product success!";
    select st, msg;
end//
delimiter ;
