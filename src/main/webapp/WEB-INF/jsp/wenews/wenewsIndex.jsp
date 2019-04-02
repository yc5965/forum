<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords">
    <script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>
    <title>我闻-文章列表</title>
    <script src="/static/jquery/jquery-3.0.0.min.js"></script>
    <link rel="stylesheet" href="/static/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="/static/lowrisk/caixin/css/index.css?v=20190121"/>
    <link rel="stylesheet" href="/static/layui/res/css/global.css">
    <script src="/static/layui/res/layui/layui.js"></script>
</head>
<style>
    .article h1 {
        color: #000;
        font-size: 28px;
        font-weight: 400;
        line-height: 36px;
        padding-bottom: 8px;
        text-align: center;
    }
    .artInfo {
        position: relative;
        height: 20px;
        line-height: 20px;
        color: #adadad;
        padding: 8px 0;
        text-align: center;
    }
    .subhead {
        font-size: 14px;
        line-height: 22px;
        padding: 5px 0;
        color: #5c5c5c;
        background: #f1f1f1;
        padding: 12px 15px;
        text-align: left;
        margin-top: 10px;
    }
    .artlink-ahref {
        color: #0eb8f6;
    }
    a {
        color: #4a4a4a;
        outline-style: none;
        text-decoration: none;
    }
    .artlink {
        text-align: left;
        margin-bottom: 30px;
    }
    .content img {
        max-width: 100%;
    }
</style>

<%@include file="../common/header.jsp" %>
<div class="main-all">
    <div class="layui-container main-con">
        <div class="layui-row main-content" id="content">
            <c:forEach items="${list}" var="data">
            <div class="layui-col-md12 main-content-item">
                <a href="${ctx}/wenews/detail/${data.article_id}" target="_blank">
                    <span class="item-title" >${data.article_title}</span>
                    <p class="item-intro" >${data.article_summary}</p>
                    <span>${data.article_create_at}</span>
                </a>
            </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>