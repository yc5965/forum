<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>首页-乐瑞大家庭</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="乐瑞大家庭">
    <script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>
    <link rel="stylesheet" href="/static/layui/res/layui/css/layui.css">
    <link rel="stylesheet" href="/static/layui/res/css/global.css">
    <script src="/static/layui/res/layui/layui.js"></script>
    <script src="/static/jquery/jquery-3.0.0.min.js"></script>
</head>
<style>
    .payItems{
        text-align: center;
        background-color: #FFFFFF;
        padding: 20px 40px 40px 80px;
     }
    .pay-time{
        padding: 40px;
        font-size: 20px;
        letter-spacing:5px
    }
    .pay-item{
        border: 1px solid #8D8D8D;
        padding: 30px;
        box-shadow: #8D8D8D 0px 0px 20px;
        margin: 25px;
    }
    .pay-text{
        font-size: 20px;
    }
    .val-1{
        font-size: 12px;
        color: red;
    }
    .val-2{
        font-size: 24px;
        color: red;
    }
    .val-3{
        color: red;
        font-size: 16px;
        margin-left: 20px;
    }
    .pay-val{
        margin-top: 15px;
    }
    .cal-pay{
        font-size: 20px;
        letter-spacing:3px
    }
    .pay-cal{
        margin-left: 10px;
        font-size: 18px;
        color: red;

    }
    .btn-pay{
        margin-left: 40px;
    }
</style>
<body>

<%@include file="common/header.jsp" %>
<div class="layui-container fly-marginTop">
    <div class="layui-col-md12 payItems">
        <div class="lay-col-md2 pay-time"><span>开通时长</span></div>
        <div class="layui-col-md4">
            <div class="pay-item" onclick="chosen(this)">
            <div class="pay-text"><span>连续包年</span></div>
            <div class="pay-val"><span class="val-1">¥</span><span class="val-2">263</span><span class="val-3">立减35元</span></div>
            </div>
            <input type="hidden" value="263">
        </div>
        <div class="layui-col-md4">
            <div class="pay-item" onclick="chosen(this)">
            <div class="pay-text"><span>连续包季</span></div>
            <div class="pay-val"><span class="val-1">¥</span><span class="val-2">68</span><span class="val-3">立减18元</span></div>
            </div>
            <input type="hidden" value="68">
        </div>
        <div class="layui-col-md4 ">
            <div class="pay-item" onclick="chosen(this)">
            <div class="pay-text"><span>连续包月</span></div>
            <div class="pay-val"><span class="val-1">¥</span><span class="val-2">25</span><span class="val-3">立减5元</span></div>
            </div>
            <input type="hidden" value="25">
        </div>
    </div>
    <div class="layui-col-md12 payItems">
        <div><span class="cal-pay">订单金额:</span><span class="pay-cal" id="pay-cal">¥0</span> <button class="layui-btn btn-pay" onclick="pay()">立即购买</button></div>
    </div>
</div>
<script>
    function chosen(e) {
        var item=$(".pay-item");
        for (var i=0; i<item.length;i++){
            item[i].style.backgroundColor="#ffffff";
        }
        e.style.backgroundColor="#1E9FFF";
        $("#pay-cal").text("¥"+ $($(e).next()).val())
    }

    function pay() {
        var price = $("#pay-cal").text().split("¥")[1];
        if (price>0) {
            window.location.href = '${ctx}/bsPay/alipaySum/'+ price
        }
    }

</script>
<!-- 加个span消除一下界面布局的BUG -->
<span></span>
</body>
</html>