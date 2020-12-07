<a href=index.html>返回</a><hr>
<?php
include("conn.php");

// 获取 customers 的数据
$customers = array();
$res = mysqli_query($conn, "select * from customers");
$row = mysqli_num_rows($res);
for($i=0; $i<$row; $i++) {
    $customers[$i] = mysqli_fetch_assoc($res);
}

// 获取 employees 的数据
$employees = array();
$res = mysqli_query($conn, "select * from employees");
$row = mysqli_num_rows($res);
for($i=0; $i<$row; $i++) {
    $employees[$i] = mysqli_fetch_assoc($res);
}

// 打印数据
$res = mysqli_query($conn, "select * from products, suppliers where products.sid=suppliers.sid");
$row = mysqli_num_rows($res);
// 遍历每行
for($i=0; $i<$row; $i++) {
    echo '<form method="GET" action="shop.bks.php"><div>';
    $product = mysqli_fetch_assoc($res);

    // 打印产品信息
    $imgIndex = (int)($i%9);    // 图片名称索引
    echo '<img src="image/' . $imgIndex . '.jpg">';
    echo '<span class="pname">' . $product["pname"] . '</span> ';
    echo '<span class="sname_city">' . $product["sname"] . ' <br> ' . $product["city"] . '</span> ';
    echo '<span class="op"><s>' . $product["original_price"] . '</s></span> ';
    echo '<span class="cp">' . $product["original_price"] * $product["discnt_rate"]  . '</span> ';

    // 隐藏表单 -- 提交产品id(pid)
    echo '<input name="pid" value=' . $product["pid"] . ' style="display:none;">';

    // 选择客户列表
    echo '<span class="customers">选择客户:<br><select name="cid">';
    echo '<option value="-1">请选择</option>';
    foreach($customers as $c) {
        echo '<option value="' . $c["cid"] . '">' . $c["cname"]. '</option>';
    }
    echo '</select></span>';

    // 选择员工列表
    echo '<span class="employees">经手员工:<br><select name="eid">';
    echo '<option value="-1">请选择</option>';
    foreach($employees as $e) {
        echo '<option value="' . $e["eid"] . '">' . $e["ename"]. '</option>';
    }
    echo '</select></span>';

    // 数量
    echo '<span class="qty">购买数量:<br><input name="qty" value="1">';
    echo ' / ' . $product["qoh"] . '</span>';

    // 购买按钮
    echo '<input type="submit" value="下单">';

    echo '</div><hr></form>';
}
?>

<style>
    div {
        display: table-cell;
        height: 200px;
        vertical-align: middle;
        text-align: center
    }
    img {
        vertical-align: middle;
        width: 180px;
        #height: 180px;
    }
    .pname {
        display: inline-block;
        width: 200px;
        font-size: 32px;
        padding: 20px;
    }
    .sname_city {
        display: inline-block;
        width: 100px;
        border: 2px black solid;
        padding: 10px;
        border-radius: 20px;
    }
    .op {
        margin-left: 20px;
        display: inline-block;
        width: 50px;
        color: gray;
    }
    .cp {
        display: inline-block;
        width: 50px;
        color: red;
        font-size: 24px;
    }
    .customers {
        margin-left: 40px;
        #background-color: red;
        display: inline-block;
        width: 120px;
    }
    .employees {
        display: inline-block;
        width: 120px;
    }
    .qty {
        display: inline-block;
        width: 150px;
        
    }
    input {
        width: 60px;
        padding: 5px;
    }
    select {
        padding: 5px;
    }
</style>
