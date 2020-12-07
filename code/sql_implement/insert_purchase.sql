use lab3;
drop procedure if exists insert_purchase;

delimiter //
create procedure insert_purchase(
    in _pur int,
    in _cid int,
    in _eid int,
    in _pid int,
    in _qty int,
    in _ptime datetime,
    in _total_price decimal(7,2)
)
insert_purchase:
begin
    # 不支持直接插入
    declare st, res int default 0;
    declare msg varchar(64) default "query fail: purchase not support insert directly!";
    select st, msg;
end//
delimiter ;
