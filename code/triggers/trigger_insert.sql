use lab3;
drop trigger if exists triger_insert_customers;
drop trigger if exists triger_insert_employees;
drop trigger if exists triger_insert_products;
drop trigger if exists triger_insert_purchases;
drop trigger if exists triger_insert_suppliers;
delimiter //

# 为 customers 表注册 insert 触发器
create trigger triger_insert_customers
after insert on customers for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "customers", "insert", NEW.cid);
end//

# 为 employees 表注册 insert 触发器
create trigger triger_insert_employees
after insert on employees for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "employees", "insert", NEW.eid);
end//

# 为 products 表注册 insert 触发器
create trigger triger_insert_products
after insert on products for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "products", "insert", NEW.pid);
end//

# 为 purchases 表注册 insert 触发器
# 注意这里我们实现业务逻辑，包括
#   1.减少存货量 
#   2.修改顾客信息
#   3.补货
create trigger triger_insert_purchases
after insert on purchases for each row
begin
    declare res int default 0;

    # 先插入记录进logs
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "purchases", "insert", NEW.pur);
    
    # 减少商品存量
    update products set qoh=qoh-NEW.qty where pid=NEW.pid;

    # 修改顾客信息
    update customers set visits_made=visits_made+1, last_visit_time=now() where cid=NEW.cid;

    # 补货
    select count(*) from products
    where pid=New.pid and qoh<qoh_threshold
    into res;
    if res>0 then
        # 这里直接带 old_qoh = qoh+NEW.qty 进去算
        update products set qoh=2*(qoh+NEW.qty) where pid=NEW.pid;
    end if;
end//

# 为 suppliers 表注册 insert 触发器
create trigger triger_insert_suppliers
after insert on suppliers for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "suppliers", "insert", NEW.sid);
end//

delimiter ;
