use lab3;
drop procedure if exists insert_product;

delimiter //
create procedure insert_product(
    in _pid int,
    in _pname varchar(15),
    in _qoh int,
    in _qoh_threshold int,
    in _original_price decimal(6,2),
    in _discnt_rate decimal(3,2),
    in _sid int
)
insert_product:
begin
    # 初始化返回结果
    declare st, res int default 0;
    declare msg varchar(64) default "query fail";

    # 检查是否存在 pid 相同的记录
    select count(pid) from products where pid=_pid limit 1 into res;
    if res>0 then
        set msg = "product already exists!";
        select st, msg;
        leave insert_product;
    end if;

    # 检查外键约束 没有对应的 supplier 则报错
    select count(sid) from suppliers where sid=_sid limit 1 into res;
    if res<1 then
        set msg = "foreign key <sid> limit: record not exists in table <suppliers>!";
        select st, msg;
        leave insert_product;
    end if;

    # 执行插入语句
    insert into `products`
    (`pid`, `pname`, `qoh`, `qoh_threshold`, `original_price`, `discnt_rate`, `sid`)
    values
    (_pid, _pname, _qoh, _qoh_threshold, _original_price, _discnt_rate, _sid);

    # 返回成功
    set st = 1;
    set msg = "insert product success!";
    select st, msg;
end//
delimiter ;
