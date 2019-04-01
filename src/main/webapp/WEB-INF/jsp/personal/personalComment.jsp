<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>个人中心-乐瑞大家庭</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="乐瑞大家庭">
    <script type="text/javascript">var ctx = '${ctx}', ctxStatic = '${ctxStatic}';</script>
    <link rel="stylesheet" href="${ctxStatic}/layui/res/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxStatic}/layui/res/css/global.css">
    <script src="${ctxStatic}/layui/res/layui/layui.js"></script>
    <script src="${ctxStatic}/jquery/jquery-3.0.0.min.js"></script>
    <style>
        .delComment:hover {
            color: #4F99CF !important;
        }
    </style>
</head>
<body>
<%@include file="../common/header.jsp" %>

<div class="layui-container fly-marginTop fly-user-main">
    <%@include file="../common/personal-left.jsp" %>
    <div class="fly-panel fly-panel-user" pad20>
        <div class="layui-tab layui-tab-brief" lay-filter="user" id="rightInfo">
        </div>
        <div id="LAY_page" style="text-align: center"></div>
    </div>
</div>

<script type="text/html" id="CommentItemTpl">
    <ul class="layui-tab-title" id="LAY_mine">
        <li data-type="mine-jie" lay-id="index" class="layui-this">我的评论（<span id="commentCount">{{d.count}}</span>）</li>
    </ul>
    <div class="layui-tab-content" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
            <ul class="mine-view jie-row">
                {{# layui.each(d.comments, function(index, item){ }}
                <li>
                    <p>
                        <i>{{layui.laytpl.toDateString(item.createDate, 'yyyy-MM-dd HH:mm')}}</i>
                        在 <a class="jie-title" href="${ctx}/home/detail?id={{item.postId}}"
                             target="_blank"
                             style="color: #4F99CF">{{item.bsPost.title}}</a>中评论：
                    </p>
                    <em style="float: right">
                        <a href="javascript:void(0);" class="delComment">
                            <i class="layui-icon" style="font-size: 20px">&#xe640;</i>
                        </a>
                        <input type="hidden" value="{{item.id}}">
                    </em>
                    <div class="home-dacontent" style="display:block;">
                        <a href="${ctx}/home/detail?id={{item.postId}}&commentId={{item.id}}" target="_blank">{{item.content}}</a>
                    </div>
                </li>
                {{# }); }}
            </ul>
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
        , base: '${ctxStatic}/layui/res/mods/'
    }).extend({
        fly: 'index'
    }).use('fly');
    layui.use(['table', 'layer', 'laytpl', 'jquery', 'laypage'], function () {
        var laytpl = layui.laytpl;
        var layer = layui.layer;
        var table = layui.table;
        var $ = jQuery = layui.$;
        var laypage = layui.laypage;
        layui.laytpl.toDateString = function (d, format) {
            var date = new Date(d || new Date())
                , ymd = [
                this.digit(date.getFullYear(), 4)
                , this.digit(date.getMonth() + 1)
                , this.digit(date.getDate())
            ]
                , hms = [
                this.digit(date.getHours())
                , this.digit(date.getMinutes())
                , this.digit(date.getSeconds())
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
        var loadItem = layer.load(0);
        $.ajax({
            url: "${ctx}/bs/bsPersonal/getPersonalComment",
            type: 'post',
            success: function (r) {
                $("#rightInfo").html("");
                if (r.data.count > 0) {
                    var data = r.data.comments.map(function(comment){
                        comment['content'] = $("<div>" + comment['content']+ "</div>").text();
                        return comment;
                    });
                    laytpl(CommentItemTpl.innerHTML).render(r.data, function (html) {
                        $("#rightInfo").append(html);
                    });
                }
                else {
                    $("#LAY_page").remove();
                    $("#rightInfo").append("<div id=\"LAY_minemsg\" style=\"margin-top: 10px;\"> <div class=\"fly-none\">暂时没有内容</div> </div>")
                }
                layer.close(loadItem);
                laypage.render({
                    elem: 'LAY_page',
                    count: r.data.count,
                    limit: 10,
                    jump: function (obj, first) {
                        if (first) {
                            return
                        }
                        var loadItem = layer.load(0);
                        $.ajax({
                            url: "${ctx}/bs/bsPersonal/getPersonalComment",
                            type: 'post',
                            data: {"pageNum": obj.curr, "pageSize": 10},
                            success: function (r) {
                                $("#rightInfo").html("");
                                var data = r.data.comments.map(function(comment){
                                    comment['content'] = $("<div>" + comment['content']+ "</div>").text();
                                    return comment;
                                });
                                laytpl(CommentItemTpl.innerHTML).render(r.data, function (html) {
                                    $("#rightInfo").append(html);
                                });
                                layer.close(loadItem);
                            }
                        })
                    }
                });
            }
        });

        $(document).on("click", ".delComment", function () {
            var delThis = this;
            var id = $(this).next().val();
            layer.confirm("确认删除这条评论？", {}, function () {
                var loadIndex = layer.load(0);
                $.ajax({
                    url: "${ctx}/bs/bsComment/delComment",
                    type: 'get',
                    data: {id: id},
                    success: function (r) {
                        layer.close(loadIndex);
                        $(delThis).parent().parent().remove();
                        var count = Number($("#commentCount").text()) - 1;
                        $("#commentCount").text(count);
                        layer.msg("操作成功！");
                    },
                    complete: function (XMLHttpRequest, textStatus) {
                        layer.close(loadIndex);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        layer.close(loadIndex);
                    }
                })
            });
        })
    });

</script>
</body>
</html>
