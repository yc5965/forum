<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>快讯</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="乐瑞大家庭">
    <script src="/static/jquery/jquery-3.0.0.min.js"></script>
    <link rel="stylesheet" href="/static/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="/static/layui/res/css/global.css">
    <script src="/static/layui/res/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" inline="javascript">
        /*<![CDATA[*/
        var ctx = /*[[@{/}]]*/ '';
        /*]]>*/
    </script>
    <style>
        .main-head {
            background-color: #28A0FC;
            width: 100%;
            height: 60px;
        }
        .news {
            padding: 0 0 10px 0;
            border-bottom: 1px #F0F0F0 solid;

        }
        .news-time {
            padding: 0 10px 0 10px;
            color: #3F3F3F;
            font-size: 12px;
        }
        .news-content {
            text-align: left;
            padding: 10px 10px 0 10px;
        }
        .layui-tab-content{
            padding: 0;
        }
    </style>

</head>

<body>

<%@include file="../common/header.jsp" %>


<div class="layui-container" style="background-color: #FFFFFF;padding: 40px">
    <div class="layui-row" id="item">
        <div class="layui-col-md12 news-item">


        </div>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show item-show">

            </div>
        </div>
        <div class="layui-col-md12" style="text-align: center">

            <div id="pageItem">

            </div>
        </div>
    </div>
</div>

<script id="newsItem" type="text/html">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title src">
            {{# layui.each(d, function(index, item){ }}
            {{# if(index ==0 ){ }}
            <li class="layui-this" onclick="pageInit(this,null)">{{item.srcName}}</li>
            {{#} else{ }}
            <li onclick="pageInit(this,null)">{{item.srcName}}</li>
            {{# } }}
            <input type="hidden" value="{{item.src}}"/>
            {{# }); }}
        </ul>
        <div class="layui-tab-content" id="channel">
            {{# layui.each(d, function(index, item){ }}
            {{# if(index ==0 ){ }}
            <div class="layui-tab-item layui-show">
                {{#} else{ }}
                <div class="layui-tab-item">
                    {{# } }}
                    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                        <ul class="layui-tab-title channel" id="{{item.src}}">
                            {{# layui.each(item.channel, function(index, channelItem){ }}
                            {{# if(index ==0 ){ }}
                            <li class="layui-this" onclick="pageInit(null,this)">{{channelItem.channelName}}</li>
                            {{#} else{ }}
                            <li onclick="pageInit(null,this)">{{channelItem.channelName}}</li>
                            {{# } }}
                            <input type="hidden" value="{{channelItem.id}}"/>
                            {{# }); }}
                        </ul>

                    </div>
                </div>
                {{# }); }}
            </div>
        </div>
    </div>
</script>

<script id="details" type="text/html">
    {{# layui.each(d, function(index, item){ }}
    <div class="news">
        <div class="news-content">
            <a href="#">
                <span>
                    {{item.subContent}}
                </span>
            </a>
        </div>
        <div class="news-time">
            <span>{{item.newsDate}}</span>
        </div>
    </div>
    {{# }); }}

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

    layui.use(['table', 'layer', 'laytpl', 'jquery', 'laypage', 'element'], function () {
        var laytpl = layui.laytpl;
        var layer = layui.layer;
        var table = layui.table;
        var $ = jQuery = layui.$;
        var laypage = layui.laypage;
        var element = layui.element;

        window.pageInit = function (a, e) {
            var channel = "";
            var pageSize = 10;
            var src = "";
            if (e == null && a == null) {
                src = $($(".src .layui-this")[0]).next().val();
                channel = $($(".channel .layui-this")[0]).next().val()
            } else if (a == null && e != null) {
                src = $($(".src .layui-this")[0]).next().val();
                channel = $(e).next().val();

            } else if (a != null && e == null) {
                src =$(a).next().val();
                channel = $($("#"+$(a).next().val()+" > .layui-this")[0]).next().val()
            }
            $(".item-show").html("");
            $.ajax({
                url: "${ctx}/cj/newsDetail",
                type: "POST",
                data: {"src": src, "channels": channel},
                success: function (da) {
                    element.init();
                    if (da.data && da.data.length > 0) {
                        var d = da.data;
                        laytpl(details.innerHTML).render(d, function (html) {
                            $(".item-show").append(html);
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
                        elem: 'pageItem'
                        , count: da.count
                        , layout:showOut
                        , limit: pageSize
                        , jump: function (obj, first) {
                            if (first) {
                                return
                            }
                            var loadIndex = layer.load(0);
                            $.ajax({
                                url: "${ctx}/cj/newsDetail",
                                type: "POST",
                                data: {"src": src, "channels": channel, "pageNum": obj.curr, "pageSize": pageSize},
                                success: function (da) {
                                    layer.close(loadIndex);
                                    if (da.data && da.data.length > 0) {
                                        $(".item-show").html("");
                                        var d = da.data;
                                        laytpl(details.innerHTML).render(d, function (html) {
                                            $(".item-show").append(html);
                                        });
                                    }
                                }
                            })
                        }
                    })
                }
            })
        };

        function init() {
            $.ajax({
                url: ctx + "/cj/newsDict",
                type: "POST",
                success: function (da) {
                    if (da.data && da.data.length > 0) {
                        var d = da.data;
                        laytpl(newsItem.innerHTML).render(d, function (html) {
                            $(".news-item").append(html);
                        });
                        pageInit(null, null);
                        element.init();
                    }
                }
            });
        }
        init();
    });
</script>

<!-- 加个span消除一下界面布局的BUG -->
<span></span>
</body>
</html>