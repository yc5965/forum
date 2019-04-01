<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="乐瑞大家庭">
    <title>${article.title}</title>
    <script src="/static/jquery/jquery-3.0.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/static/lowrisk/caixin/css/companies.min.css"/>
    <link rel="stylesheet" type="text/css" href="/static/lowrisk/caixin/css/newart.css"/>
    <link rel="stylesheet" href="/static/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="/static/lowrisk/caixin/css/index.css?v=20190121"/>
    <link rel="stylesheet" type="text/css" href="/static/lowrisk/caixin/css/content.css"/>
    <link rel="stylesheet" href="/static/layui/res/css/global.css">
    <script src="/static/layui/res/layui/layui.js"></script>

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



<div class="main-article">
    <div class="layui-container">
        <div class="layui-row">
            <div class="layui-col-md12">
                <div id="the_content" class="article">
                    <div id="conTit">
                        <h1>
                            ${article.title}
                            <em class="icon_key"></em>
                        </h1>
                        <div class="artInfo" id="artInfo">
                            ${article.artTime.split('可以')[0]}
                        </div>
                        <c:if test="${not empty article.introduction}">
                        <div id="subhead" class="subhead" style="text-align: center">
                                ${article.introduction}
                        </div>
                        </c:if>
                    </div>

                    <div class="media">
                        <c:if test="${ not empty  article.imageUrl}">
                        <div class="layui-carousel" id="itemImg">
                            <div carousel-item="">
                                <c:forEach items="${article.imageUrl.split(',')}" var="imgUrl">
                                    <c:if test="${not empty imgUrl}">
                                        <div>
                                            <img src="${imgUrl}" class="artImgurl">
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                        </c:if>
                    </div>

                    <div class="content">
                        <div class="textbox">
                            <div id="Main_Content_Val" class="text">
                                ${article.content}
                            </div>
                        </div>
                    </div>
                    <div class="artlink">
                        原文：<a href="${article.pageUrl}"  class="artlink-ahref"
                              target="_blank">${article.pageUrl}</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


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

</script>

<!-- 加个span消除一下界面布局的BUG -->
<span></span>
</body>
</html>