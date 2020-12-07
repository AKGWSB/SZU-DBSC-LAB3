<?php
include("conn.php");

$cid = $_GET["cid"];
$eid = $_GET["eid"];
$pid = $_GET["pid"];
$qty = $_GET["qty"];

$res = mysqli_query($conn, 'call add_purchase(' . $cid . ',' . $eid . ',' . $pid . ',' . $qty . ')');
$row = mysqli_num_rows($res);
// 获取 sql 接口的返回信息
$fetch_array = mysqli_fetch_array($res);
$st = $fetch_array[0];
$msg = $fetch_array[1];

// 响应
if($st==1) {
    $st = "成功";
} else {
    $st = "失败";
}
echo '<script>alert("状态: ' .$st . '\n信息: ' . $msg . '");window.location.href=document.referrer;</script>';
?>