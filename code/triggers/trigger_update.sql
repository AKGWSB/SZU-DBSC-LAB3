use lab3;
drop trigger if exists triger_update_customers;
drop trigger if exists triger_update_employees;
drop trigger if exists triger_update_products;
drop trigger if exists triger_update_purchases;
drop trigger if exists triger_update_suppliers;
delimiter //

# 为 customers 表注册 update 触发器
create trigger triger_update_customers
after update on customers for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "customers", "update", NEW.cid);
end//

# 为 employees 表注册 update 触发器
create trigger triger_update_employees
after update on employees for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "employees", "update", NEW.eid);
end//

# 为 products 表注册 update 触发器
create trigger triger_update_products
after update on products for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "products", "update", NEW.pid);
end//

# 为 purchases 表注册 update 触发器
create trigger triger_update_purchases
after update on purchases for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "purchases", "update", NEW.pur);
end//

# 为 suppliers 表注册 update 触发器
create trigger triger_update_suppliers
after update on suppliers for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "suppliers", "update", NEW.sid);
end//

delimiter ;
