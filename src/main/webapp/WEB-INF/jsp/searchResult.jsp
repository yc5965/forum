<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>搜索</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="乐瑞大家庭">
    <script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>
    <link rel="stylesheet" href="/static/lowrisk/caixin/css/index.css?v=20190121">
    <link rel="stylesheet" href="/static/layui/res/layui/css/layui.css">
    <link rel="stylesheet" href="/static/layui/res/css/global.css">
    <script src="/static/layui/res/layui/layui.js"></script>
    <script src="/static/jquery/jquery-3.0.0.min.js"></script>
</head>
<style>
    @media screen and (max-width: 768px) {
        #caixinNav li {
            padding: 0;
            min-width: 50px;
        }
    }
</style>
<body>
<input type="hidden" value="${searchVal}" id="hidVal">
<%@include file="common/header.jsp" %>
<div class="main-all">
    <div class="layui-container main-con">
        <div class="layui-row main-content" id="content" style="padding: 30px">
        </div>
        <div class="layui-row main-foot" style="margin-top: 40px">
            <div class="layui-col-md12" id="page" style="text-align: center">

            </div>
        </div>
    </div>
</div>
<script id="artItem" type="text/html">
    <div class="layui-col-md12 main-content-item">
        {{# if (d.articleType =='我闻'){}}
        <a href="${ctx}/wenews/detail/{{d.id}}" target="_blank">
            {{#} else{ }}
            <a href="${ctx}/caixinIndex/getArticle/{{d.id}}" target="_blank">
                {{# } }}
                <span class="item-title"> {{d.title}} </span> ---<span>{{d.articleType}}</span>
                <p class="item-intro">{{d.introduction}}</p>
                <span>{{d.artTime}}</span>
            </a>
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
        $("#searchVal").val($("#hidVal").val());
        var pageSize = 10;
        $.ajax({
            url:  "${ctx}/caixinIndex/searchPage",
            type: "POST",
            data: {"pageNum": 1, "pageSize": pageSize, "searchVal": $("#searchVal").val()},
            success: function (data) {
                $("#content").html("");
                if (data.articles.length < 1) {
                    $("#content").append("<div class='no-data-container'>未查到<span class='no-data-ele-container'>" + $("#searchVal").val() + "</span>相关信息！</div>");
                }
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
                    showOut =  ['prev','page', 'next']
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
                        $.ajax({
                            url: "${ctx}/caixinIndex/searchPage",
                            type: "POST",
                            data: {"pageNum": obj.curr, "pageSize": pageSize, "searchVal": $("#ser").val()},
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
    });
</script>

<!-- 加个span消除一下界面布局的BUG -->
<span></span>
</body>
</html>