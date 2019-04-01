<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<ul class="layui-nav layui-nav-tree layui-inline" id="personalNav" lay-filter="user">
    <li class="layui-nav-item">
        <a href="${ctx}/home/user?id=${sessionScope.user.id}">
            <i class="layui-icon">&#xe68e;</i> 我的主页
        </a>
    </li>
    <li class="layui-nav-item ">
        <a href="${ctx}/home/personal/personalDynamic" id="dynamicTab">
            <i class="layui-icon">&#xe702;</i> 我的动态
        </a>
    </li>
    <li class="layui-nav-item">
        <a href="${ctx}/home/personal/personalPost" id="postTab">
            <i class="layui-icon">&#xe655;</i> 我的帖子
        </a>
    </li>
    <li class="layui-nav-item">
        <a href="${ctx}/home/personal/personalComment" id="commentTab">
            <i class="layui-icon">&#xe611;</i> 我的评论
        </a>
    </li>
    <li class="layui-nav-item">
        <a href="${ctx}/home/personal/personalLike" id="likeTab">
            <i class="layui-icon">&#xe6c6;</i> 我的点赞
        </a>
    </li>
</ul>

</li>
<div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
</div>
<div class="site-mobile-shade"></div>

<div class="site-tree-mobile layui-hide">
    <i class="layui-icon">&#xe602;</i>
</div>
<div class="site-mobile-shade"></div>

<style>
    #personalNav{
        max-height:600px;
    }
 </style>

<script>
    var locationUrl = window.location.href;
    if (locationUrl.indexOf("personalDynamic") != -1) {
        $("#dynamicTab").addClass("layui-this")
    } else if (locationUrl.indexOf("personalPost") != -1) {
        $("#postTab").addClass("layui-this");
    } else if (locationUrl.indexOf("personalComment") != -1) {
        $("#commentTab").addClass("layui-this");
    }else if (locationUrl.indexOf("personalLike") != -1) {
        $("#likeTab").addClass("layui-this");
    }
</script>