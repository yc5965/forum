<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords">
    <script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>
    <title>${article.article_title}</title>
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
<div class="main-article">
    <div class="layui-container">
        <div class="layui-row">
            <div class="layui-col-md12">
                <div id="the_content" class="article">
                    <div id="conTit">
                        <h1>
                            ${article.article_title}
                            <em class="icon_key"></em>
                        </h1>
                        <div id="subhead" class="subhead">
                            ${article.article_summary}
                        </div>
                    </div>
                    <div style="width: 100%;" if="${article.containsKey('article_audio_url')}">
                        <audio autoplay="autoplay" style="width: 100% !important;" src="${article.containsKey('article_audio_url')? article.article_audio_url:''}" controls="controls" ></audio>
                    </div>
                    <div class="content" style="background: #fff;text-align: left;padding: 20px;">
                        <div class="textbox">
                            <div id="Main_Content_Val" class="text">
                                ${article.article_desc}
                            </div>
                        </div>
                    </div>
                    <div class="artlink" style="background: #fff;padding: 0 20px 20px 20px;">
                        原文：<a href="${article.article_url}" class="artlink-ahref"
                              target="_blank">${article.article_url}</a>
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
</body>
</html>