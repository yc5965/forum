<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="乐瑞大家庭">
    <title>${toutiao.weeklyNum}</title>
    <script src="/static/jquery/jquery-3.0.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/static/lowrisk/caixin/css/common_v2.css"/>
    <link rel="stylesheet" type="text/css" href="/static/lowrisk/caixin/css/channelCommon_temp.css"/>
    <link type="text/css" rel="stylesheet" href="/static/lowrisk/caixin/css/magezine_danqi.css"/>
    <link type="text/css" rel="stylesheet" href="/static/lowrisk/caixin/css/magazine.css"/>
    <link rel="stylesheet" href="/static/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="/static/lowrisk/caixin/css/index.css?v=20190121"/>
    <link rel="stylesheet" href="/static/layui/res/css/global.css">
    <script src="/static/layui/res/layui/layui.js"></script>
    <script type="text/javascript" inline="javascript">
        /*<![CDATA[*/
        var ctx = /*[[@{/}]]*/ '';
        /*]]>*/
    </script>
    <script src="/static/lowrisk/caixin/js/item-0.0.1.js" charset="utf-8"></script>

</head>

<body>

<%@include file="../common/header.jsp" %>

<div class="main">
    <div class="mainMagContent">
        <div class="report">

            <div class="title" >${toutiao.weeklyNum}</div>
            <div class="source" >${toutiao.weeklyTime}</div>
            <div class="reportTit">封面报道　<span>Cover Story</span></div>
            <dl>
                <dt><a href="/caixinWeekly/getWeeklyArticle/${toutiao.id}" target="_blank">${toutiao.weeklyTitle}</a></dt>
                <dd >${toutiao.weeklySummary}</dd>
            </dl>
            <br>
            <c:forEach items="${futiao}" var="futs">
                <ul  class="futItem" style="text-align: left">
                    <c:forEach items="${futs.artList}" var="fut">
                    <ol>
                    <p><a href="/caixinWeekly/getWeeklyArticle/${fut.id}" target="_blank">${fut.title}</a></p>
                    </ol>
                    </c:forEach>
                </ul>
            </c:forEach>
            <div class="date">
                <img alt="${toutiao.weeklyNum}" src="${toutiao.weeklyIssueImage}">
            </div>
        </div>
        <div class="cover">
            <img alt="${toutiao.weeklyNum}" src="${toutiao.weeklyImage}">
        </div>
        <div class="clear"></div>

        <div class="magContent2">
            <div class="magContentTit"></div>
            <div class="magIntro2">
                <div class="magContentlf2">
                    <c:forEach items="${weeklyArticles1}" var="weeklyArtTypes">
                    <div>
                        <div class="magIntrotit"><span >${weeklyArtTypes.artType}</span></div>
                        <c:forEach items="${weeklyArtTypes.artList}" var="weeklyArticle">
                        <dl>
                            <dt><a href="/caixinWeekly/getWeeklyArticle/${weeklyArticle.id}" target="_blank">${weeklyArticle.title}</a></dt>
                            <dd class="date"></dd>
                            <dd>${weeklyArticle.introduction}</dd>
                        </dl>
                        </c:forEach>
                    </div>
                    </c:forEach>
                </div>
                <div class="magContentce">
                    <c:forEach items="${weeklyArticles2}" var="weeklyArtTypes">
                    <div>
                        <div class="magIntrotit"><span>${weeklyArtTypes.artType}</span></div>
                        <c:forEach items="${weeklyArtTypes.artList}" var="weeklyArticle">
                        <dl>
                            <dt><a href="/caixinWeekly/getWeeklyArticle/${weeklyArticle.id}" target="_blank">${weeklyArticle.title}</a></dt>
                            <dd class="date"></dd>
                            <dd>${weeklyArticle.introduction}</dd>
                        </dl>
                        </c:forEach>
                    </div>
                    </c:forEach>
                </div>

                <div class="magContentri2">
                    <c:forEach items="${weeklyArticles3}" var="weeklyArtTypes">
                    <div>
                        <div class="magIntrotit"><span>${weeklyArtTypes.artType}</span></div>
                        <c:forEach items="${weeklyArtTypes.artList}" var="weeklyArticle">
                        <dl>
                            <dt><a href="/caixinWeekly/getWeeklyArticle/${weeklyArticle.id}" target="_blank">${weeklyArticle.title}</a></dt>
                            <dd class="date"></dd>
                            <dd>${weeklyArticle.introduction}</dd>
                        </dl>
                        </c:forEach>
                    </div>
                    </c:forEach>
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