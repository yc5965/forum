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
    .fly-none {
        padding-bottom: 50px;
        min-height: 0px;
    }

    .fly-filter .article-sort {
        color: #5FB878;
    }
    .article-sort {
        color: #5FB878;
    }
    .tags{
        padding-right: 6px;
    }
</style>
<body>

<%@include file="common/header.jsp" %>
<div class="layui-container" style="margin-top:15px">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div id="carouselItem" class="layui-hide layui-hide-xs">
                <div class="fly-panel">
                    <div class="layui-row fly-panel-main" style="padding: 15px;">
                        <div class="layui-carousel fly-topline" id="FLY_topline" style="width: 100%; height: 172px;">
                            <div carousel-item="">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="topItem" class="layui-hide">
                <div class="fly-panel">
                    <div class="fly-panel-title fly-filter">
                        <a>置顶</a>
                    </div>
                    <ul class="fly-list" id="Topping">

                    </ul>
                </div>
            </div>

            <div class="fly-panel" style="margin-bottom: 0;" id="postContainer">
                <div class="fly-panel-title fly-filter">
                    <a href="javascript:void(0)" class="layui-this" onclick="initPostArea(this,null)">综合</a>
                    <input type="hidden" value="">
                    <a href="javascript:void(0)" onclick="initPostArea(this,null)">公告</a>
                    <input type="hidden" value="0">
                    <a href="javascript:void(0)" onclick="initPostArea(this,null)">提问</a>
                    <input type="hidden" value="1">
                    <a href="javascript:void(0)" onclick="initPostArea(this,null)">分享</a>
                    <input type="hidden" value="2">
                    <a href="javascript:void(0)" onclick="initPostArea(this,null)">建议</a>
                    <input type="hidden" value="3">

                    <span class="fly-filter-right layui-hide-xs">
                        <a href="javascript:void(0)" class="article-sort" onclick="initPostArea(null,this)">按最新</a>
                        <input type="hidden" value="">
                        <span class="fly-mid"></span>
                        <a href="javascript:void(0)" onclick="initPostArea(null,this)">按最热</a>
                        <input type="hidden" value="hottest">
                    </span>

                </div>
                <ul class="fly-list" id="pageItem">
                </ul>
                <div style="text-align: center">
                    <div id="page">

                    </div>
                </div>

            </div>
        </div>
        <div class="layui-col-md4">
            <%@include file="common/right-panel.jsp" %>
        </div>
    </div>
</div>

<script type="text/html" id="carouselItemTpl">
    {{#  layui.each(d, function(index, item){ }}
    <div>
        <a href="${ctx}/home/detail?id={{item.id}}" target="_blank">
            <img src="{{item.coverImg}}" alt="{{item.title}}" style="width:100%;height:100%;">
        </a>
    </div>
    {{#  }); }}
</script>

<script type="text/html" id="ToppingItemTpl">

    <li>
        <a href="${ctx}/home/user?id={{d.createBy.id}}" class="fly-avatar" target="_blank">
            <img src="${ctxStatic}/{{d.createBy.photo}}"
                 alt="{{d.createBy.name}}">
        </a>
        <h2>
            <a class="layui-badge">{{d.postTypeLabel}}</a>
            <a href="${ctx}/home/detail?id={{d.id}}" target="_blank">{{d.title}}</a>
        </h2>
        <div class="fly-list-info">
            <a href="${ctx}/home/user?id={{d.createBy.id}}" link="" target="_blank">
                <cite>{{d.createBy.name}}</cite>
            </a>

            {{#  layui.each(d.tags, function(index, item){ }}
            <span class="layui-hide-xs layui-badge layui-bg-red fly-detail-column tags">{{item}}</span>
            {{#  }); }}

            <span>{{layui.laytpl.toDateString(d.createDate, 'yyyy-MM-dd HH:mm')}}</span>

            {{# if(d.commentCount >0){ }}
            <span class="fly-list-nums">
              <i class="iconfont icon-pinglun1" title="评论"></i> {{d.commentCount}}
            </span>
            {{#} else{ }}
            <span class="fly-list-nums">
                <i class="iconfont icon-pinglun1" title="评论"></i> 0</span>
            {{# } }}

        </div>
        {{# if(d.postStatus == '1'){ }}
        <div class="fly-list-badge"><span class="layui-badge layui-bg-red">置顶</span></div>
        {{# } }}
    </li>
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
    layui.use(['table', 'layer', 'laytpl', 'jquery', 'laypage'], function () {
        var laytpl = layui.laytpl;
        var layer = layui.layer;
        var table = layui.table;
        var $ = jQuery = layui.$;
        var laypage = layui.laypage;

        function initCarousel() {
            $.ajax({
                url: "/bs/bsPost/getByStatus",
                type: "POST",
                data: {"postStatus": "2"},
                success: function (r) {
                    if (r.data && r.data.length > 0) {
                        var data = r.data;
                        laytpl(carouselItemTpl.innerHTML).render(data, function (html) {
                            $("#FLY_topline>[carousel-item]").append(html);
                        });
                        layui.use('carousel', function () {
                            var carousel = layui.carousel;
                            //建造实例
                            carousel.render({
                                elem: '#FLY_topline'
                                , width: '100%' //设置容器宽度
                                , arrow: 'hover' //始终显示箭头
                                , height: '175'
                                , indicator: 'none'
                            });
                        });
                        $("#carouselItem").removeClass("layui-hide");
                    }
                }
            })
        }

        function initTopArea() {
            $.ajax({
                url: "/bs/bsPost/getByStatus",
                type: "POST",
                data: {"postStatus": "1"},
                success: function (r) {
                    if (r.data && r.data.length > 0) {
                        var data = r.data;
                        for (var i=0;i<data.length;i++) {
                            var d = data[i];
                            if (d.postTags != "" && d.postTags != null) {
                                d["tags"] = d.postTags.split(",");
                            }
                            laytpl(ToppingItemTpl.innerHTML).render( d, function (html) {
                                $("#Topping").append(html);
                            });
                        }
                        $("#topItem").removeClass("layui-hide");
                    }
                }
            })
        }

        window.initPostArea = function (e, t) {
            var pageSize = 30;
            if (e != null) {
                $("#postContainer").find(".layui-this").removeClass('layui-this');
                $(e).addClass("layui-this");
            }
            if (t != null) {
                $("#postContainer").find(".article-sort").removeClass('article-sort');
                $(t).addClass("article-sort");
            }
            var loadIndex = layer.load(0);
            var postType = $("#postContainer").find(".layui-this")[0];
            var sortType = $("#postContainer").find(".article-sort")[0];
            var dt = {
                "postType": $(postType).next().val(),
                "sortType": $(sortType).next().val(),
                "pageNum": 1, "pageSize": pageSize
            };
            $.ajax({
                url: "/bs/bsPost/getPageList",
                type: "POST",
                data: dt,
                success: function (da) {
                    layer.close(loadIndex);
                    $("#pageItem").html("");
                    if (da.data && da.data.length > 0) {
                        var data = da.data;
                        for (var i=0;i<data.length;i++) {
                            var d = data[i];
                            if (d.postTags!=""&&d.postTags!=null){
                                d["tags"] = d.postTags.split(",");
                            }
                            laytpl(ToppingItemTpl.innerHTML).render(d, function (html) {
                                $("#pageItem").append(html);
                            });
                        }
                    } else {
                        $("#pageItem").append("<div class='fly-none'>暂无相关帖子！</div>");
                    }
                    laypage.render({
                        elem: 'page'
                        , count: da.count
                        , limit: pageSize
                        , jump: function (obj, first) {
                            if (first) {
                                return;
                            }
                            var loadIndex = layer.load(0);
                            $.ajax({
                                url: "/bs/bsPost/getPageList",
                                type: "POST",
                                data: {"pageNum": obj.curr, "pageSize": pageSize, "sortType":  $(sortType).next().val(), "postType": $(postType).next().val()},
                                success: function (r) {
                                    layer.close(loadIndex);
                                    $("#pageItem").html("");
                                    if (r.data && r.data.length > 0) {
                                        var data = r.data;
                                        for (var i=0;i<data.length;i++){
                                            var d =data[i];
                                            if (d.postTags!=""&&d.postTags!=null){
                                                d["tags"] = d.postTags.split(",");
                                            }
                                            laytpl(ToppingItemTpl.innerHTML).render(d, function (html) {
                                                $("#pageItem").append(html);
                                            });
                                        }

                                    } else {
                                        $("#pageItem").append("<div class='fly-none'>暂无相关帖子！</div>");
                                    }
                                }

                            });
                        }
                    })
                },
                complete: function (XMLHttpRequest, textStatus) {
                    layer.close(loadIndex);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.close(loadIndex);
                }
            });
        };

        initCarousel();
        initTopArea();
        initPostArea(null,null);

        layui.laytpl.toDateString = function(d, format){
            var date = new Date(d || new Date())
                ,ymd = [
                this.digit(date.getFullYear(), 4)
                ,this.digit(date.getMonth() + 1)
                ,this.digit(date.getDate())
            ]
                ,hms = [
                this.digit(date.getHours())
                ,this.digit(date.getMinutes())
                ,this.digit(date.getSeconds())
            ];

            format = format || 'yyyy-MM-dd HH:mm:ss';

            return format.replace(/yyyy/g, ymd[0])
                .replace(/MM/g, ymd[1])
                .replace(/dd/g, ymd[2])
                .replace(/HH/g, hms[0])
                .replace(/mm/g, hms[1])
                .replace(/ss/g, hms[2]);
        };

        layui.laytpl.digit = function(num, length, end){
            var str = '';
            num = String(num);
            length = length || 2;
            for(var i = num.length; i < length; i++){
                str += '0';
            }
            return num < Math.pow(10, length) ? str + (num|0) : num;
        };
    })
</script>

<!-- 加个span消除一下界面布局的BUG -->
<span></span>
</body>
</html>