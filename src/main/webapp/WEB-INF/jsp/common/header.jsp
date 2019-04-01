<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    @media screen and ( max-width: 768px ) {
        #addHeaderBtn {
            margin-top: 12px;
        }
    }
    .layui-bg-white{
        background: #fff !important;
        border-bottom: #fff !important;
        border-right: #fff !important;
    }
</style>

<div class="fly-header layui-bg-white">
    <div class="layui-container" id="head_user">
        <a class="fly-logo" href="${ctx}/home/index">
            <img src="${ctxStatic}/layui/res/images/logo.png" alt="layui">
        </a>
        <ul class="layui-nav fly-nav " style="margin-left:160px;">
            <c:if test="">
            <li class="layui-nav-item layui-this layui-hide-xs">
                <a href="${ctx}" style="padding:0 25px 0 25px;color:#000000 ">后台管理</a>
            </li>
            </c:if>
        </ul>




    </div>
</div>

<div class="fly-panel fly-column">
    <div class="layui-container">
        <ul class="layui-clear">
            <li class="layui-hide-xs layui-this"><a href="${ctx}/home/index">首页</a></li>
            <li class="layui-hide-xs"><a href="${ctx}/caixin/indexCaixin">财新头条</a></li>
            <li class="layui-hide-xs"><a href="${ctx}/cj/news">资讯快看</a></li>
            <li  class="layui-hide-xs"><a href="">基金信息</a></li>
            <li  class="layui-hide-xs"><a href="${ctx}/caixin/weeklyCaixin">新闻周刊</a></li>
        </ul>
    </div>
</div>

<script id="nologin" type="text/html">
    <ul class="layui-nav fly-nav-user" id="nologin-ul">
        <!-- 未登入的状态 -->
        <li class="layui-nav-item">
            <a class="iconfont icon-touxiang layui-hide-xs" href="${ctx}/login/loginIndex"></a>
        </li>
        <li class="layui-nav-item">
            <a style="color: #000000" href="${ctx}/login/loginIndex">登入</a>
        </li>
        <li class="layui-nav-item">
            <a style="color: #000000" href="${ctx}/login/regIndex">注册</a>
        </li>
    </ul>
</script>

<script id="islogin" type="text/html">
    <ul class="layui-nav fly-nav-user" id="islogin-ul">
        <li class="layui-nav-item">
            <a class="fly-nav-avatar" href="javascript:;">
                <cite class="layui-hide-xs">${sessionScope.user.name}</cite>
                <c:choose>
                    <c:when test="${sessionScope.user.userType ==0}">
                        <i class="iconfont icon-renzheng layui-hide-xs" title="管理标志"></i>
                    </c:when>
                    <c:when test="${sessionScope.user.userType ==2}">
                        <i class="layui-badge fly-badge-vip layui-hide-xs" title="到期时间:${sessionScope.user.expireDate}">VIP</i>
                    </c:when>
                </c:choose>
                <img src="${ctxStatic}/${sessionScope.user.photo}">
            </a>
            <dl class="layui-nav-child">
                <dd><a href="${ctx}/home/personal/personalDynamic"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>个人中心</a></dd>
                <dd><a href="${ctx}/home/user?id=${sessionScope.user.id}"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>
                <hr style="margin: 5px 0;">
                <dd><a href="${ctx}/login/logout" style="text-align: center;">退出</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item" style="padding-left: 20px">
            <c:if test="${sessionScope.user.userType ==1}">
                <a class="layui-btn layui-btn-container" href="${ctx}/home/pay" style="color:#fff;">成为会员</a>
            </c:if>
        </li>
        <li class="layui-nav-item" id="addHeaderBtn" style="padding-left: 20px">
            <a class="layui-btn layui-btn-danger" href="${ctx}/home/add" style="color:#fff;">我要发布</a>
        </li>
    </ul>
</script>




<script type="text/javascript">

    $(function(){
        var user='${sessionScope.user}';
        if(user==''){
            $("#head_user").append($("#nologin").text());
        }else{
            $("#head_user").append($("#islogin").text());
        }
    });
</script>
