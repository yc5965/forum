<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>财新网-周刊</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="乐瑞大家庭">
    <link rel="stylesheet" href="/static/layui/res/layui/css/layui.css">
    <link rel="stylesheet" href="/static/lowrisk/caixin/css/index.css?v=20190121">
    <link rel="stylesheet" href="/static/layui/res/css/global.css">
    <script src="/static/layui/res/layui/layui.js"></script>
    <script src="/static/jquery/jquery-3.0.0.min.js"></script>
    <style>
        @media screen and (max-width: 768px) {
            #caixinNav li{
                padding: 0;
                min-width: 50px;
            }
        }
    </style>

</head>

<body>

<%@include file="../common/header.jsp" %>



<div class="main-all">
    <div class="layui-container main-con">
        <div class="layui-row main-content" id="content">
        </div>
        <div class="layui-row main-foot" style="margin-top: 40px">
            <div class="layui-col-md12" id="page" style="text-align: center">

            </div>
        </div>
    </div>
</div>
<script id="weeklyItem" type="text/html">
    <div class="layui-col-md3 ">
        <div class="weekly-item">
            <a href="/caixinWeekly/getWeekly/{{d.id}}" target="_blank"><img src="{{d.weeklyImage}}" class="weekly-image"/></a>
            <div class="weekly-title">
                <a href="/caixinWeekly/getWeekly/{{d.id}}"
                   class="weekly-title-item">{{d.weeklyTitle.split('】')[1]? d.weeklyTitle.split('】')[1]: d.weeklyTitle.split('|')[1] }}</a>
                <br><span class="weekly-title-time">{{d.weeklyNum}}<br>{{d.weeklyTime.split('《财新周刊》')[1]}}</span>
            </div>
        </div>
    </div>
</script>


<script>
    layui.cache.page = '';
    layui.cache.user = {
        uid: -1
    };
    layui.config({
        version: "3.0.0"
        , base: '/static/layui/res/mods/' //这里实际使用时，建议改成绝对路径
    }).extend({
        fly: 'index'
    }).use('fly');

    layui.use(['laypage', 'layer', 'laytpl'], function () {
        var laypage = layui.laypage;
        var laytpl = layui.laytpl;
        var element = layui.element;
        layer = layui.layer;
        function weeklyCaixin() {
            var data = null;
            var pageSize = 12;
            $.ajax({
                url: "${ctx}/caixinWeekly/weeklyPage",
                type: "POST",
                data: {"pageNum": 1, "pageSize": pageSize},
                success: function (data) {
                    $("#content").html("");
                    for (var i = 0; i < data.articles.length; i++) {
                        var d = data.articles[i];
                        laytpl(weeklyItem.innerHTML).render(d, function (html) {
                            $("#content").append(html);
                        });
                    }
                    var layout = /Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent) ? true : false;
                    var showOut = [];
                    if (layout) {
                        showOut = ['count', 'prev', 'next']
                    }else {
                        showOut = ['prev','page', 'next']
                    }
                    laypage.render({
                        elem: 'page'
                        , count: data.pageCount
                        , limit: pageSize
                        , layout:showOut
                        , jump: function (obj, first) {
                            if (first) {
                                return
                            }
                            data = {"pageNum": obj.curr, "pageSize": pageSize};
                            $.ajax({
                                url: "${ctx}/caixinWeekly/weeklyPage",
                                type: "POST",
                                data: data,
                                success: function (data) {
                                    $("#content").html("");
                                    for (var i = 0; i < data.articles.length; i++) {
                                        var d = data.articles[i];
                                        laytpl(weeklyItem.innerHTML).render(d, function (html) {
                                            $("#content").append(html);
                                        });
                                    }
                                }
                            })
                        }
                    });
                }
            });
        }
        weeklyCaixin();
    });


</script>

<!-- 加个span消除一下界面布局的BUG -->
<span></span>
</body>
</html>