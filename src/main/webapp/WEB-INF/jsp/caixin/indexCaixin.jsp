<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>财新网-头条</title>
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
    <div class="main-con layui-container " style="padding-left: 40px">
        <div class="layui-row main-content" id="content">
        </div>
        <div class="layui-row main-foot">
            <div class="layui-col-md12" id="page" style="text-align: center">

            </div>
        </div>
    </div>
</div>
<script id="artItem" type="text/html">
    <div class="layui-col-md12 main-content-item">
        <a href="/caixin/getArticle/{{d.id}}" target="_blank">
            <span class="item-title"> {{d.title}} </span>
            <p class="item-intro">{{d.introduction}}</p>
            <span>{{d.artTime}}</span>
        </a>
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
        function indexCaixin() {
            var data = null;
            var pageSize = 10;
            $.ajax({
                url: "${ctx}/caixin/indexPage",
                type: "POST",
                data: {"pageNum": 1, "pageSize": pageSize},
                success: function (data) {
                    $("#content").html("");
                    for (var i = 0; i < data.articles.length; i++) {
                        var d = data.articles[i];
                        laytpl(artItem.innerHTML).render(d, function (html) {
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
                                url: "${ctx}/caixin/indexPage",
                                type: "POST",
                                data: data,
                                success: function (data) {
                                    $("#content").html("");
                                    for (var i = 0; i < data.articles.length; i++) {
                                        var d = data.articles[i];
                                        laytpl(artItem.innerHTML).render(d, function (html) {
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
        indexCaixin();
    });


</script>

<!-- 加个span消除一下界面布局的BUG -->
<span></span>
</body>
</html>