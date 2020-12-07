use lab3;

# ---- insert into employees:
insert into `employees`
(`eid`, `ename`, `city`)
values
(90071, "bobWang", "GuangZhou"),
(90072, "samZhang", "ShangHai"),
(90073, "ZeMinJiang", "ShangHai"),
(90074, "DaSiMa", "WuHu"),
(90075, "MalaTang", "ChengDu");

# ---- insert into customers:
insert into `customers`
(`cid`, `cname`, `city`, `visits_made`, `last_visit_time`)
values
(114, "ShiYouLao", "HengYang", 3, "2020-12-2 16:03"),
(514, "SCWang", "MaoMing", 2, "2020-12-1 12:12"),
(191, "GaoKuaiDian", "BeiJin", 5, "2020-11-29 06:19"),
(981, "TuanTuan", "NewYork", 9, "2020-12-6 22:59");

# ---- insert into suppliers:
insert into `suppliers`
(`sid`, `sname`, `city`, `telephone_no`)
values
(8081, "HuaWei", "DongGuan", "13670778081"),
(4396, "XiaoMi", "ShangHai", "15343214396"),
(7777, "Apple", "BeiJIn", "18922007777");

# ---- insert into products:
insert into `products`
(`pid`, `pname`, `qoh`, `qoh_threshold`, `original_price`, `discnt_rate`, `sid`)
values
(3306, "mate40", 2147, 999, 778.00, 0.95, 8081),
(3307, "mate40pro", 364, 19, 556.00, 0.95, 8081),
(7158, "RedMi", 100, 50, 220.00, 0.85, 4396),
(7159, "SE-8", 100, 99, 440.00, 0.75, 4396),
(443, "iphoneX", 110, 23, 987.00, 1.00, 7777),
(444, "iphone12", 67, 28, 998.00, 1.00, 7777);
