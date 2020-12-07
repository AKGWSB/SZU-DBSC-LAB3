# change all eid, cid, pid, pur, key_value to int types in the future
drop database if exists lab3;
create database if not exists lab3;
use lab3;

create table employees (
    eid int not null, 
    ename varchar(15),
    city varchar(15),
    primary key(eid)
);

create table customers (
    cid int not null,
    cname varchar(15),
    city varchar(15),
    visits_made int,
    last_visit_time datetime,
    primary key(cid)
);

create table suppliers (
    sid int not null,
    sname varchar(15) not null,
    city varchar(15),
    telephone_no char(11),
    primary key(sid),
    unique(sname)
);

create table products (
    pid int not null,
    pname varchar(15) not null,
    qoh int not null,
    qoh_threshold int,
    original_price decimal(6,2),
    discnt_rate decimal(3,2),
    sid int,
    primary key(pid),
    foreign key (sid) references suppliers (sid)
);

create table purchases (
    pur int not null auto_increment,
    cid int not null,
    eid int not null,
    pid int not null,
    qty int,
    ptime datetime,
    total_price decimal(7,2),
    primary key (pur),
    foreign key (cid) references customers(cid),
    foreign key (eid) references employees(eid),
    foreign key (pid) references products(pid)
);

create table logs (
    logid int not null auto_increment,
    who varchar(10) not null,
    time datetime not null,
    table_name varchar(20) not null,
    operation varchar(6) not null,
    key_value int,
    primary key (logid)
); 
