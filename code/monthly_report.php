<script type="text/javascript" src="lib_js/jscharts_mb.js"></script>
<div align="center">
<h2>查询报表 -- 输入产品id</h2>
<form method="GET">
<input name="pid"><input type="submit" value="查询">
</form><a href=index.html>返回</a><hr>
<?php
include("conn.php");

if(!isset($_GET["pid"]) || $_GET["pid"]=='') {
    die("请选择产品");
} else {
    $pid = $_GET["pid"];
}

$data = array();  // 按年份分类存储数据

// 查询报表
$columns = array();
$res = mysqli_query($conn, 'call report_monthly_sale(' . $pid . ')');
$row = mysqli_num_rows($res);
for($i=0; $i<$row; $i++) {
    $dbrow = mysqli_fetch_array($res);
    $year = $dbrow[2];
    // 按照年份分组
    if(!isset($data[$year])) {
        $data[$year] = array(); // 不存在则新建
    }
    // fetch_array 转为纯 array 方便 JSON 序列化
    $arr = array();
    for($j=0; $j<6; $j++) {
        $arr[$j] = $dbrow[$j];
    }
    array_push($data[$year], $arr);  // 存在则加入
}

// 判断是否查询为空
if(count($data)==0) {
    die('<script>alert("没有数据!");</script>');
}

// 将数据通过JSON传递给JavaScript
echo "<script>var data=JSON.parse('" . json_encode($data) . "');</script>";

// debug
// echo "console.log(data);</script>"; echo 'json_encode($data)';

// 分年份打印表
foreach($data as $year => $yearTable) {
    // 打印表头
    echo '<h3>' . $year . '年报表</h3><table border="2"><tr><td>产品名称</td><td>月份</td><td>年份</td><td>销量</td><td>总价</td><td>均价</td></tr>';
    // 打印行数据
    foreach($yearTable as $row) {
        echo '<tr>';
        // 打印列
        for($j=0; $j<6; $j++) {
            echo '<td>' . $row[$j] . '</td>';
        }
        echo '</tr>';
    }
    echo '</table>';
    echo '<div id="' . $year . '1" style="display:inline-block;"></div>';  // 打印表格容器
    echo '<div id="' . $year . '2" style="display:inline-block;"></div><hr>';  
}
?>
</div>

<script type="text/javascript">
    // 月份映射与颜色映射
    var mmap = {"Jan":1, "Feb":2, "Mar":3, "Apr":4, "May":5, "Jun":6, "Jul":7, "Aug":8, "Sep":9, "Oct":10, "Nov":11, "Dec":12};
    var cmap = {"Jan":"#FFFF00", "Feb":"#FFC125", "Mar":"#FF83FA", "Apr":"#FF4500   ", "May":"#FFB90F", "Jun":"#BF3EFF", "Jul":"#98FB98", "Aug":"#7FFF00", "Sep":"#8B8378", "Oct":"#76EE00", "Nov":"#1E90FF", "Dec":"#00CDCD"};
    // 遍历每年的数据 -- 每年的数据为一张表
    for(var year in data) {
        var chartData = new Array();
        var chartColor = new Array();
        var rows = data[year];
        //console.log(rows);    // debug
        for(var i=0; i<rows.length; i++) {
            var row = rows[i];  // 每一行数据
            //console.log(row); // debug
            var point = [row[1], parseFloat(row[4])];   // 插入 [月份, 总额]
            chartData.push(point);
            chartColor.push(cmap[row[1]]);
        }
        //console.log(chartData);   // debug
        var chart1 = new JSChart(year.toString()+'1', 'bar');
        chart1.setDataArray(chartData);
        chart1.colorizeBars(chartColor);
        chart1.draw();
        var chart2 = new JSChart(year.toString()+'2', 'pie');
        chart2.setDataArray(chartData);
        chart2.colorizePie(chartColor);
        chart2.draw();
    }
</script>

<style>
    tr {
        text-align: center;
    }
    td {
        padding: 10px;
    }
</style>