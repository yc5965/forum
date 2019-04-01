<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>个人信息-乐瑞大家庭</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="乐瑞大家庭">
  <script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>
  <link rel="stylesheet" href="${ctxStatic}/layui/res/layui/css/layui.css">
  <link rel="stylesheet" href="${ctxStatic}/layui/res/css/global.css">
  <script src="${ctxStatic}/jquery/jquery-3.0.0.min.js" type="text/javascript"></script>
  <style>
    #mainContent .layui-badge{
      height: 16px;
      line-height: 16px;
      padding: 0 5px;
      margin-right: 10px;
      font-size: 12px;
      border: 1px solid #5FB878;
      background: none;
      color: #5FB878;
    }
  </style>
</head>

<body>

<%@include file="common/header.jsp" %>
<div class="fly-home fly-panel">
  <img src="${ctxStatic}${user.photo}" alt="${user.name}">
  <h1>
    ${user.name}
  </h1>
</div>


<div class="layui-container">
  <div class="layui-row layui-col-space15" style="margin: 0">
    <div class="layui-col-md6 fly-home-jie">
      <div class="fly-panel">
        <h3 class="fly-panel-title">${user.name} 最近的帖子</h3>
        <ul class="jie-row" id="mainContent" style="min-height: 0px">
        </ul>
        <div id="postPage" style="text-align: center"></div>
      </div>

    </div>
    
    <div class="layui-col-md6 fly-home-da">
      <div class="fly-panel">
        <h3 class="fly-panel-title">${user.name} 最近的评论</h3>
        <ul class="home-jieda" id="commentContent" style="min-height: 0px">
        </ul>
        <div id="commentPage" style="text-align: center"></div>
      </div>

    </div>
  </div>
</div>


<script src="${ctxStatic}/layui/res/layui/layui.js"></script>
<script>
layui.cache.page = 'user';
layui.cache.user = {
    uid: -1
};
layui.config({
  version: "3.0.0"
  ,base: '${ctxStatic}/layui/res/mods/'
}).extend({
  fly: 'index'
}).use('fly');

layui.use(['jquery', 'layer', 'laytpl', 'util', 'fly','laypage'], function(){
    var laytpl = layui.laytpl;
    var laypage = layui.laypage;
    var loadIndex = layer.load(0);
    var $ = jQuery = layui.$;
    var fly = layui.fly;
    var pageSize = 20;
    $.ajax({
        url: "${ctx}/bs/bsPost/getUserPosts",
        type: 'post',
        data: {'createById': '${user.id}'},
        success: function (r) {
            if (r.data.posts && r.data.posts.length > 0) {
                var data = r.data.posts;
                laytpl(postsTpl.innerHTML).render(data, function (html) {
                    $("#mainContent").append(html);
                })
            } else {
                $("#mainContent").append("<p style='text-align: center'>暂无相关帖子！</p>");
            }
            laypage.render({
                elem: 'postPage',
                count: r.data.count,
                limit: pageSize,
                jump: function (obj, first) {
                    if (first) {
                        return
                    }
                    var loadItem = layer.load(0);
                    $.ajax({
                        url: "${ctx}/bs/bsPost/getUserPosts",
                        type: 'post',
                        data: {"pageNum": obj.curr, "pageSize": pageSize, 'createBy.id': '${user.id}'},
                        success: function (r) {
                            $("#mainContent").html("");
                            var data = r.data.posts;
                            laytpl(postsTpl.innerHTML).render(data, function (html) {
                                $("#mainContent").append(html);
                                layer.close(loadItem);
                            });
                        }
                    });

                }
            });
            layer.close(loadIndex);
        },
        complete: function (XMLHttpRequest, textStatus) {
            layer.close(loadIndex);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            layer.close(loadIndex);
        }
    });
    $.ajax({
        url:"${ctx}/bs/bsComment/getUserComment",
        type:'get',
        data:{'createById':'${user.id}'},
        success:function(r){
            if(r.data.comments && r.data.comments.length > 0) {
                var data = r.data.comments.map(function(comment){
                    comment['content'] = $("<div>" + comment['content']+ "</div>").text();
                    return comment;
                });
                laytpl(commentsTpl.innerHTML).render(data, function(html){
                    $("#commentContent").append(html);
                })
            }else{
                $("#commentContent").append("<p style='text-align: center'>暂无相关评论！</p>");
            }
            laypage.render({
                elem: 'commentPage',
                count: r.data.count,
                limit: pageSize,
                jump: function (obj, first) {
                    if (first) {
                        return
                    }
                    var loadItem = layer.load(0);
                    $.ajax({
                        url: "${ctx}/bs/bsComment/getUserComment",
                        type: 'post',
                        data: {"pageNum": obj.curr, "pageSize": pageSize, 'createBy.id': '${user.id}'},
                        success: function (r) {
                            $("#commentContent").html("");
                            var data = r.data.comments.map(function(comment){
                                comment['content'] = $("<div>" + comment['content']+ "</div>").text();
                                return comment;
                            });
                            laytpl(commentsTpl.innerHTML).render(data, function(html){
                                $("#commentContent").append(html);
                                layer.close(loadItem);
                            });
                        }
                    })
                }
            });
        }
    });

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
});

</script>
<script type="text/html" id="postsTpl">
  {{#  layui.each(d, function(index, item){ }}
  <li>
    <span class="layui-badge">{{item.postTypeLabel}}</span>
    <a href="${ctx}/home/detail?id={{item.id}}" class="jie-title" target="_blank"> {{item.title}}</a>
    <i>{{layui.laytpl.toDateString(item.createDate, 'yyyy-MM-dd')}}</i>
    <em><i class="iconfont icon-pinglun1" title="评论"></i> {{item.commentCount ? item.commentCount : 0}}</em>
  </li>
  {{#  }); }}
</script>

<script type="text/html" id="commentsTpl">
  {{#  layui.each(d, function(index, item){ }}
  <li>
    <p>
      <span>{{layui.laytpl.toDateString(item.createDate, 'yyyy-MM-dd HH:mm')}}</span>
      在<a class="jie-title" href="${ctx}/home/detail?id={{item.postId}}&commentId={{item.id}}" target="_blank">{{item.bsPost.createBy.name}}：{{item.bsPost.title}}</a>中评论：
    </p>
    <div class="home-dacontent">
      {{item.content}}
    </div>
  </li>
  {{#  }); }}
</script>

<script type="text/html" id="userBrifTpl">
  {{#  layui.each(d, function(index, item){ }}
  <div class="layui-col-md2 layui-col-xs4">
    <div>
      <div>{{item.label}}</div>
      <div>{{item.value}}</div>
    </div>
  </div>
  {{#  }); }}
</script>

</body>
</html>