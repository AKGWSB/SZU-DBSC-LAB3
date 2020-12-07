use lab3;
drop trigger if exists triger_delete_customers;
drop trigger if exists triger_delete_employees;
drop trigger if exists triger_delete_products;
drop trigger if exists triger_delete_purchases;
drop trigger if exists triger_delete_suppliers;
delimiter //

# 为 customers 表注册 delete 触发器
create trigger triger_delete_customers
after delete on customers for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "customers", "delete", OLD.cid);
end//

# 为 employees 表注册 delete 触发器
create trigger triger_delete_employees
after delete on employees for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "employees", "delete", OLD.eid);
end//

# 为 products 表注册 delete 触发器
create trigger triger_delete_products
after delete on products for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "products", "delete", OLD.pid);
end//

# 为 purchases 表注册 delete 触发器
create trigger triger_delete_purchases
after delete on purchases for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "purchases", "delete", OLD.pur);
end//

# 为 suppliers 表注册 delete 触发器
create trigger triger_delete_suppliers
after delete on suppliers for each row
begin
    insert into logs (`who`, `time`, `table_name`, `operation`, `key_value`)
    values
    (USER(), NOW(), "suppliers", "delete", OLD.sid);
end//

delimiter ;
