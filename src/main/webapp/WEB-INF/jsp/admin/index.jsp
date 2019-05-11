<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <title>后台 - 乐瑞大家庭</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/static/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="/static/layuiadmin/style/admin.css" media="all">

    <script>
        /^http(s*):\/\//.test(location.href) || alert('请先部署到 localhost 下再访问');
    </script>
</head>
<body class="layui-layout-body">

<div id="LAY_app">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <!-- 头部区域 -->
            <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item layadmin-flexible" lay-unselect>
                    <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
                        <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="${ctx}/home/index" target="_blank" title="前台">
                        <i class="layui-icon layui-icon-website"></i>
                    </a>
                </li>
                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;" layadmin-event="refresh" title="刷新">
                        <i class="layui-icon layui-icon-refresh-3"></i>
                    </a>
                </li>
            </ul>
            <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="theme">
                        <i class="layui-icon layui-icon-theme"></i>
                    </a>
                </li>

                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;">
                        <cite>${sessionScope.user.name}</cite>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a lay-href="${ctx}/home/personal/personalDynamic">个人中心</a></dd>
                        <dd><a lay-href="${ctx}/home/user?id=${sessionScope.user.id}">我的主页</a></dd>
                        <hr>
                        <dd style="text-align: center;"><a href="${ctx}/login/logout">退出</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="about"><i class="layui-icon layui-icon-more-vertical"></i></a>
                </li>
                <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect>
                    <a href="javascript:;" layadmin-event="more"><i class="layui-icon layui-icon-more-vertical"></i></a>
                </li>
            </ul>
        </div>

        <!-- 侧边菜单 -->
        <div class="layui-side layui-side-menu">
            <div class="layui-side-scroll">
                <div class="layui-logo" lay-href="home/console.html">
                    <span>乐瑞社区后台管理</span>
                </div>

                <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
                    <li data-name="home" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="主页" lay-direction="2">
                            <i class="layui-icon layui-icon-home"></i>
                            <cite>主页</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd data-name="console" class="layui-this">
                                <a lay-href="home/console.html">控制台</a>
                            </dd>
                        </dl>
                    </li>
                    <li data-name="user" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="用户" lay-direction="2">
                            <i class="layui-icon layui-icon-user"></i>
                            <cite>用户</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a lay-href="${ctxStatic}/views/admin/userList.html" lay-text="">用户信息</a>
                            </dd>
                        </dl>
                    </li>
                    <li data-name="component" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="帖子" lay-direction="2">
                            <i class="layui-icon layui-icon-component"></i>
                            <cite>帖子</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a lay-href="${ctxStatic}/views/admin/postList.html" lay-text="">帖子管理</a>
                            </dd>
                        </dl>
                    </li>
                    <li data-name="component" class="layui-nav-item">
                        <a href="javascript:;" lay-tips="数据管理" lay-direction="2">
                            <i class="layui-icon layui-icon-component"></i>
                            <cite>组件</cite>
                        </a>
                        <dl class="layui-nav-child">
                            <dd data-name="table">
                                <a href="javascript:;">数据表格</a>
                                <dl class="layui-nav-child">
                                    <dd data-name="simple">
                                        <a lay-href="${ctxStatic}/views/component/table/userList.html" lay-text="">简单数据表格</a>
                                    </dd>
                                    <dd data-name="auto">
                                        <a lay-href="${ctxStatic}/views/component/table/auto.html" lay-text="">列宽自动分配</a>
                                    </dd>
                                    <dd data-name="data">
                                        <a lay-href="${ctxStatic}/views/component/table/data.html" lay-text="">赋值已知数据</a>
                                    </dd>
                                    <dd data-name="tostatic">
                                        <a lay-href="${ctxStatic}/views/component/table/tostatic.html" lay-text="">转化静态表格</a>
                                    </dd>
                                    <dd data-name="page">
                                        <a lay-href="${ctxStatic}/views/component/table/page.html" lay-text="">开启分页</a>
                                    </dd>
                                    <dd data-name="resetPage">
                                        <a lay-href="${ctxStatic}/views/component/table/resetPage.html" lay-text="">帖子管理</a>
                                    </dd>
                                    <dd data-name="height">
                                        <a lay-href="${ctxStatic}/views/component/table/height.html" lay-text="">高度最大适应</a>
                                    </dd>
                                    <dd data-name="checkbox">
                                        <a lay-href="${ctxStatic}/views/component/table/checkbox.html" lay-text="">开启复选框</a>
                                    </dd>
                                    <dd data-name="cellEdit">
                                        <a lay-href="${ctxStatic}/views/component/table/cellEdit.html" lay-text="">开启单元格编辑</a>
                                    </dd>
                                    <dd data-name="form">
                                        <a lay-href="${ctxStatic}/views/component/table/form.html" lay-text="">加入表单元素</a>
                                    </dd>
                                    <dd data-name="style">
                                        <a lay-href="${ctxStatic}/views/component/table/style.html" lay-text="">设置单元格样式</a>
                                    </dd>
                                    <dd data-name="fixed">
                                        <a lay-href="${ctxStatic}/views/component/table/fixed.html" lay-text="">固定列</a>
                                    </dd>
                                    <dd data-name="operate">
                                        <a lay-href="${ctxStatic}/views/component/table/operate.html" lay-text="">数据操作</a>
                                    </dd>
                                    <dd data-name="reload">
                                        <a lay-href="${ctxStatic}/views/component/table/reload.html" lay-text="">数据表格的重载</a>
                                    </dd>
                                    <dd data-name="initSort">
                                        <a lay-href="${ctxStatic}/views/component/table/initSort.html" lay-text="">设置初始排序</a>
                                    </dd>
                                    <dd data-name="cellEvent">
                                        <a lay-href="${ctxStatic}/views/component/table/cellEvent.html" lay-text="">监听单元格事件</a>
                                    </dd>
                                    <dd data-name="thead">
                                        <a lay-href="${ctxStatic}/views/component/table/thead.html" lay-text="">复杂表头</a>
                                    </dd>
                                </dl>
                            </dd>
                            <dd data-name="upload">
                                <a href="javascript:;">上传</a>
                                <dl class="layui-nav-child">
                                    <dd data-name="demo1">
                                        <a lay-href="${ctxStatic}/views/component/upload/demo1.html" lay-text="上传功能演示一">功能演示一</a>
                                    </dd>
                                    <dd data-name="demo2">
                                        <a lay-href="${ctxStatic}/views/component/upload/demo2.html" lay-text="上传功能演示二">功能演示二</a>
                                    </dd>
                                </dl>
                            </dd>
                        </dl>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 页面标签 -->
        <div class="layadmin-pagetabs" id="LAY_app_tabs">
            <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-down">
                <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
                    <li class="layui-nav-item" lay-unselect>
                        <a href="javascript:;"></a>
                        <dl class="layui-nav-child layui-anim-fadein">
                            <dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
                            <dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
                            <dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
                        </dl>
                    </li>
                </ul>
            </div>
            <div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
                <ul class="layui-tab-title" id="LAY_app_tabsheader">
                    <li lay-id="home/console.html" class="layui-this"><i class="layui-icon layui-icon-home"></i></li>
                </ul>
            </div>
        </div>


        <!-- 主体内容 -->
        <div class="layui-body" id="LAY_app_body">
            <div class="layadmin-tabsbody-item layui-show">
                <iframe src="${ctxStatic}/views/home/console.html" frameborder="0" class="layadmin-iframe"></iframe>
            </div>
        </div>

        <!-- 辅助元素，一般用于移动设备下遮罩 -->
        <div class="layadmin-body-shade" layadmin-event="shade"></div>
    </div>
</div>

<script src="/static/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '/static/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use('index');
</script>
</body>
</html>
