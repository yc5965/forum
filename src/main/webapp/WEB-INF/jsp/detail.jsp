<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>${bsPost.title}-乐瑞大家庭</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="keywords" content="乐瑞大家庭">
  <script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>
  <script src="${ctxStatic}/jquery/jquery-3.0.0.min.js" type="text/javascript"></script>
  <script src="${ctxStatic}/jquery/jquery-migrate-3.0.0.js" type="text/javascript"></script>
  <link rel="stylesheet" href="${ctxStatic}/layui/res/layui/css/layui.css">
  <link rel="stylesheet" href="${ctxStatic}/layui/res/css/global.css">
  <script src="${ctxStatic}/layui/res/layui/layui.js"></script>

  <!-- summernote -->
  <link href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.css" type="text/css" rel="stylesheet" />
  <script src="${ctxStatic}/bootstrap/3.3.7/js/bootstrap.min.js" type="text/javascript"></script>
  <link href="${ctxStatic}/summernote/summernote.css" rel="stylesheet">
  <script src="${ctxStatic}/summernote/summernote.min.js?v=20180423"></script>
  <script src="${ctxStatic}/summernote/lang/summernote-zh-CN.js"></script>

  <style>
    body{
      background-color: #f2f2f2
    }
    legend{
      border-bottom: 0px;
      width: auto;
      margin-bottom: 0px;
    }
    .total-yield-container{
      text-align: right;
      margin-right: 10px;
      font-weight: 400;
      font-size: 1.17em
    }
    ol, ul {
      margin-bottom: 0px;
    }
    .modal-dialog{
      margin-top: 60px !important;
    }

    .fly-list-nums .zanok,.fly-list-nums .zanok i, .fly-list-nums .jieda-zan:hover i,.fly-list-nums .jieda-zan:hover{
      color: #C00 !important;
      cursor: pointer;
    }
    h3{
      margin: 0px
    }
    .modal-dialog input[type=checkbox]{
      display: block;
    }
    @media screen and (max-width: 768px) {
      .detail-body video{
        width: 100%;
      }
    }
  </style>
</head>
<body>

<%@include file="common/header.jsp" %>

<div class="layui-container fly-marginTop">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md8 content detail">
      <div class="fly-panel detail-box">
        <h1 style="margin-top: 0;margin-bottom: 0;font-weight: 400">${bsPost.title}</h1>

        <div class="fly-detail-info">
          <span class="layui-badge layui-bg-green fly-detail-column"> ${bsPost.postTypeLabel} </span>
          <c:forEach items="${bsPost.postTags}" var="tag">
            <span class="layui-badge layui-bg-red fly-detail-column"> ${tag} </span>
          </c:forEach>
          <c:if test="${bsPost.postStatus == 1}">
            <span class="layui-badge layui-bg-red">置顶</span>
          </c:if>
          <span class="fly-list-nums">
            <span class="jieda-zan <c:if test="${bsPost.isLike == 1}">zanok</c:if>" type="postZan"> <i class="iconfont icon-zan"></i> <em>${bsPost.likeCount != null ? bsPost.likeCount:0}</em> </span>
            <a href="#comment"><i class="iconfont" title="回答"></i>${bsPost.commentCount != null ? bsPost.commentCount:0}</a>
            <i class="iconfont" title="查看人数"></i>${bsPost.viewCount != null ? bsPost.viewCount:0}
          </span>
        </div>

        <div class="detail-about">
          <a class="fly-avatar" href="${ctx}/home/user?id=${bsPost.createBy.id}">
            <img src="${ctxStatic}${bsPost.createBy.photo}" alt="${bsPost.createBy.name}">
          </a>
          <div class="fly-detail-user">
            <a href="${ctx}/home/user?id=${bsPost.createBy.id}" class="fly-link">
              <cite>${bsPost.createBy.name}</cite>
            </a>
          </div>
          <div class="detail-hits" id="LAY_jieAdmin">
            <span style="padding-right: 10px;color: #999"><fmt:formatDate value="${bsPost.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
            <c:if test="${sessionScope.user.id == bsPost.createBy.id}">
              <span class="layui-btn layui-btn-xs jie-admin" type="edit"><a href="${ctx}/home/add?id=${bsPost.id}">编辑</a></span>
              <span class="layui-btn layui-btn-danger layui-btn-xs jie-admin" type="delPost">删除</span>
            </c:if>
          </div>
        </div>
        <div class="detail-body layui-text photos">
          ${bsPost.content}
        </div>
      </div>

      <div class="fly-panel detail-box" id="flyReply">
        <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
          <legend>回帖</legend>
        </fieldset>

        <ul class="jieda" id="commentArea">
        </ul>

        <div class="layui-form layui-form-pane">
          <form action="" method="post">
            <div class="layui-form-item layui-form-text">
              <a name="comment"></a>
              <div class="layui-input-block">
                <div class="summernote" id="commentContent"></div>
              </div>
            </div>
            <div class="layui-form-item">
              <input type="hidden" name="postId" value="${bsPost.id}">
              <button class="layui-btn" lay-filter="add" lay-submit="" >提交评论</button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="layui-col-md4">
      <%@include file="common/right-panel.jsp" %>
    </div>
  </div>
</div>

<script>
  layui.cache.page = 'jie';
  layui.cache.user = {
    uid: -1
  };
  layui.config({
    version: "3.0.0"
    ,base: '${ctxStatic}/layui/res/mods/'
  }).extend({
    fly: 'index'
  }).use(['fly', 'face'], function(){
    var $ = layui.$
            ,fly = layui.fly;
  });

  layui.use(['jquery', 'layer', 'laytpl', 'util', 'form', 'fly','element'], function(){
    var laytpl = layui.laytpl;
    var form = layui.form;
    var $ = jQuery = layui.$;
    var fly = layui.fly;
    var element = layui.element;

    initComments(function () {
      var loadIndex = layer.load(0);
      var locationUrl = window.location.href;
      var commentId = "${commentId}";
      //获取当前的锚点
      if (commentId) {
        var target = $("li[data-id=" + commentId + "]");
        var targetOffset = $(target).offset().top - 60;
        $('html,body').animate({
          scrollTop: targetOffset
        }, 300);
      }
      layer.close(loadIndex);
    });
    var configs = [];
    $(function () {
      $('.summernote').summernote({
        height: 200,
        minHeight: null,
        maxHeight: null,
        focus: true,
        lang: 'zh-CN'
      });
    });

    form.on('submit(add)', function(data){
      var content = $('#commentContent').summernote('code');
      if($('#commentContent').summernote('isEmpty')){
        layer.msg("请输入内容！", {icon: 5});
        $('#commentContent').summernote('focus');
        return false;
      }
      var formData = data.field;
      formData['content'] = content;
      var loadIndex = layer.load(0);
      $.ajax({
        url:"${ctx}/bs/bsComment/saveComment",
        contentType: "application/json;charset=UTF-8",
        type:'post',
        data:JSON.stringify({"postId":data.field.postId,"content":data.field.content}),
        success:function(r){
          layer.close(loadIndex);
          initComments(function(){
            layer.msg("操作成功！");
            $('#commentContent').summernote('code',"")
          });
        },
        complete:function(XMLHttpRequest,textStatus){
          layer.close(loadIndex);
        },
        error:function(XMLHttpRequest,textStatus,errorThrown){
          layer.close(loadIndex);
        }
      });
      return false;
    });
    $(document).on("click", "span[type='reply']", function(){
      var li = $(this).parent().parent();
      var val = $("<p>" + $('#commentContent').summernote('code') + "</p>").text();
      var aite = '@'+ li.find('.fly-detail-user cite').text().replace(/\s/g, '');
      $('#commentContent').summernote('focus');
      if(val.indexOf(aite) !== -1) {
        $('#commentContent').summernote('keepLastIndex');
        return;
      }
      $('#commentContent').summernote('insertText', aite + ' ');
      $('#commentContent').summernote('keepLastIndex');
    });

    $(document).on("click", "span[type='del']", function(){
      var id = $(this).parents("li").attr("data-id");
      layer.confirm("确认删除这条评论？",{}, function () {
        var loadIndex = layer.load(0);
        $.ajax({
          url:"${ctx}/bs/bsComment/delComment",
          type:'POST',
          data:JSON.stringify({id:id}),
          contentType : "application/json;charset=utf-8",
          dataType:"json",
          success:function(r){
            layer.close(loadIndex);
            initComments(function(){
              layer.msg("操作成功！");
            });
          },
          complete:function(XMLHttpRequest,textStatus){
            layer.close(loadIndex);
          },
          error:function(XMLHttpRequest,textStatus,errorThrown){
            layer.close(loadIndex);
          }
        })
      });
    })

    $(document).on("click", "span[type='delPost']", function(){
      var id = '${bsPost.id}';
      layer.confirm("确认删除该篇文章？",{}, function () {
        var loadIndex = layer.load(0);
        $.ajax({
          url:"${ctx}/bs/bsPost/deletePost",
          type:'post',
          data:JSON.stringify({id:id}),
          contentType : "application/json;charset=utf-8",
          dataType:"json",
          success:function(r){
            layer.msg("删除成功，自动跳转首页!");
            setTimeout(function() {window.location.href = '${ctx}/home/index'},1000);
          },
          complete:function(XMLHttpRequest,textStatus){
            layer.close(loadIndex);
          },
          error:function(XMLHttpRequest,textStatus,errorThrown){
            layer.close(loadIndex);
          }
        })
      });
    });

    $(document).on("click", "span[type='zan']", function(){
      var that = $(this);
      var id = $(this).parents("li").attr("data-id");
      var loadIndex = layer.load(0);
      $.ajax({
        url:"${ctx}/bs/bsLike/like",
        type:'post',
        data:JSON.stringify({likeType:1, refId: id}),
        contentType : "application/json;charset=utf-8",
        dataType:"json",
        success:function(r){
          layer.close(loadIndex);
          if(r.status == 'ok' && r.data) {
            if(r.data.likeStatus == 0){
              that.removeClass("zanok");
              layer.msg("取消赞成功！");
            }else if(r.data.likeStatus == 1){
              that.addClass("zanok");
              layer.msg("点赞成功！");
            }
            that.find("em").html(r.data.likeCount);
          }

        },
        complete:function(XMLHttpRequest,textStatus){
          layer.close(loadIndex);
        },
        error:function(XMLHttpRequest,textStatus,errorThrown){
          layer.close(loadIndex);
        }
      })
    })

    $(document).on("click", "span[type='postZan']", function(){
      var that = $(this);
      var loadIndex = layer.load(0);
      $.ajax({
        url:"${ctx}/bs/bsLike/like",
        type:'post',
        data:JSON.stringify({likeType:0, refId: '${bsPost.id}'}),
        contentType : "application/json;charset=utf-8",
        dataType:"json",
        success:function(r){
          layer.close(loadIndex);
          if(r.status == 'ok' && r.data) {
            if(r.data.likeStatus == 0){
              that.removeClass("zanok");
              layer.msg("取消赞成功！");
            }else if(r.data.likeStatus == 1){
              that.addClass("zanok");
              layer.msg("点赞成功！");
            }
            that.find("em").html(r.data.likeCount);
          }

        },
        complete:function(XMLHttpRequest,textStatus){
          layer.close(loadIndex);
        },
        error:function(XMLHttpRequest,textStatus,errorThrown){
          layer.close(loadIndex);
        }
      })
    })

    $(".photos img[data-media-type='attachment']").click(function(){
      window.open($(this).attr("path"));
      return false
    })


    function setYDYContent(content, ele){
      var noteRe = /^(http|https):\/\/note\.youdao\.com\/(noteshare|share\/)(index\.html|)\?id=.*$/;
      //有道云协作正则
      var groupRe = /^(http|https):\/\/note\.youdao\.com\/(groupshare|share\/)(index\.html|)\?token=.*$/;
      var layerIndex = 0;
      if(noteRe.test(content)) {
        $.ajax({
          url:"https://home.lowrisk.com.cn/lrtools/ydy/note",
          type:'get',
          data:{url:encodeURI(content)},
          beforeSend:function(XMLHttpRequest){
            layerIndex = layer.load(0, {time: 20*1000,shade:0.3});
          },
          success:function(res){
            $(ele).summernote('reset');
            $(ele).summernote('code', res.data);
            layer.close(layerIndex);
          },
          complete:function(XMLHttpRequest,textStatus){
            layer.close(layerIndex);
          },
          error:function(XMLHttpRequest,textStatus,errorThrown){
            layer.close(layerIndex);
          }
        })
      }
      else if(groupRe.test(content)) {
        $.ajax({
          url:"https://home.lowrisk.com.cn/lrtools/ydy/group",
          type:'get',
          data:{url:encodeURI(content)},
          beforeSend:function(XMLHttpRequest){
            layerIndex = layer.load(0, {time: 20*1000,shade:0.3});
          },
          success:function(res){
            $(ele).summernote('reset');
            $(ele).summernote('code', res.data);
            $(ele).summernote('keepLastIndex');
            layer.close(layerIndex);
          },
          complete:function(XMLHttpRequest,textStatus){
            layer.close(layerIndex);
          },
          error:function(XMLHttpRequest,textStatus,errorThrown){
            layer.close(layerIndex);
          }
        })
      }
    }
    function escape2Html(str) {
      var arrEntities={'lt':'<','gt':'>','nbsp':' ','amp':'&','quot':'"'};
      return str.replace(/&(lt|gt|nbsp|amp|quot);/ig,function(all,t){return arrEntities[t];});
    }

    function initComments(callBack) {
      var loadIndex = layer.load(0);
      var commentId = "${commentId}";
      $.ajax({
        url: "${ctx}/bs/bsComment/getCommentByTab",
        type: 'post',
        data: {"postId": '${bsPost.id}', "id": commentId},
        success: function (r) {
          $("#commentArea").empty();
          if (r.data.count > 0) {
            for (var i = 1; i <= (r.data.count + 4) / 5; i++) {
              var d = r.data;
              d.index = i;
              d.count = r.data.count;
              d.length = parseInt((r.data.count + 4) / 5);
              laytpl(tabNumSort.innerHTML).render(d, function (html) {
                $("#commentArea").append(html);
              });
              if (i == Number(r.data.tabNum)) {
                var da = r.data.comments.map(function (comment) {
                  comment['content'] = escape2Html(fly.content(comment['content']));
                  return comment;
                });
                laytpl(commentTpl.innerHTML).render(da, function (html) {
                  $("#commentTab" + i).removeClass("showPost");
                  $("#commentTab" + i).addClass("closePost");
                  $("#commentTab" + i).prev().css("text-decoration","underline");
                  $("#commentTab" + i).html("<i class='layui-icon'>&#xe619;</i>");
                  $("#commentArea").append(html);
                });
              }
            }
          } else {
            $("#commentArea").append('<li class="fly-none">消灭零回复</li>');
          }
          if (callBack && typeof callBack == 'function') {
            callBack();
          }
          layer.close(loadIndex);
        },
        complete: function (XMLHttpRequest, textStatus) {
          layer.close(loadIndex);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
          layer.close(loadIndex);
        }
      })
    }

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


    window.showPost = function (e, tabNum) {
      var loadIndex = layer.load(0);
      $.ajax({
        url: "${ctx}/bs/bsComment/getPostComment",
        type: 'post',
        data: {"postId": '${bsPost.id}', "tabNum": tabNum},
        success: function (r) {
          if (r && r.data.comments && r.data.comments.length > 0) {
            var da = r.data.comments.map(function (comment) {
              comment['content'] = escape2Html(fly.content(comment['content']));
              return comment;
            });
            laytpl(commentTpl.innerHTML).render(da, function (html) {
              $(e).parent().after(html);
              $(e).removeClass("showPost");
              $(e).addClass("closePost");
              $(e).prev().css("text-decoration","underline");
              $(e).html("<i class='layui-icon'>&#xe619;</i>")
            });
            layer.close(loadIndex);
          }
        }
      })
    };

    window.closePost = function (e, tabNum) {
      $(e).parent().next().remove();
      $(e).addClass("showPost");
      $(e).removeClass("closePost");
      $(e).prev().css("text-decoration","none");
      $(e).html("<i class='layui-icon'>&#xe61a;</i>")
    }
  });
  function fileSelectAction(fileUrl, data, allFiles) {
    var fileName = decodeURIComponent(fileUrl.substring(fileUrl.lastIndexOf("/") + 1));
    if (isImg(fileName)) {
      $('#commentContent').summernote("insertImage", fileUrl);
    } else {
      var linkNode = document.createElement("a");
      linkNode.href = fileUrl;
      linkNode.target = "_blank";
      linkNode.appendChild(document.createTextNode(fileName));
      $('#commentContent').summernote('insertNode', linkNode);
    }
  }
  function isImg(fileName) {
    var suffixIndex = fileName.lastIndexOf(".");
    var suffix = fileName.substring(suffixIndex + 1).toUpperCase();
    return suffix == "BMP" || suffix == "JPG" || suffix == "JPEG" || suffix == "PNG" || suffix == "GIF";
  }
  // 打开一个窗体
  function windowOpen(url, name, width, height) {
    var top = parseInt((window.screen.height - height) / 2, 10),
            left = parseInt((window.screen.width - width) / 2, 10),
            options = "location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes," +
                    "resizable=yes,scrollbars=yes," + "width=" + width + ",height=" + height + ",top=" + top + ",left=" + left;
    window.open(url, name, options);
  }

  function togglePost(e, tabNum) {
    if ($(e).attr("class") == 'togglePost') {
      if ($(e).next().attr("class") == 'closePost') {
        closePost($(e).next(), tabNum);
      } else if ($(e).next().attr("class") == 'showPost') {
        showPost($(e).next(), tabNum);
      }
    } else {
      if ($(e).attr("class") == 'closePost') {
        closePost(e, tabNum);
      } else if ($(e).attr("class") == 'showPost') {
        showPost(e, tabNum);
      }
    }
  }
</script>
<script type="text/html" id="tabNumSort">
  <li data-id="{{d.index}}">
    <a href="javascript:void(0);" class="togglePost" onclick="togglePost(this,{{d.index}})">
      <span style="color: #0B61A4"># {{(d.index-1)*5+1}} - {{d.index == d.length? d.count : d.index*5}}.评论详情</span>
    </a>
    <a href="javascript:void(0);" onclick="togglePost(this,{{d.index}})" id="{{'commentTab'+d.index}}" class="showPost"
       title="展开" style="float: right;margin-right: 30px">
      <i class="layui-icon">&#xe61a;</i>
    </a>
  </li>
</script>

<script type="text/html" id="commentTpl">
  <ul>
  {{#  layui.each(d, function(index, item){ }}
  <li data-id="{{item.id}}" class="posts">
    <a name="item-{{item.id}}"></a>
    <div class="detail-about detail-about-reply">
      <a class="fly-avatar" href="${ctx}/home/user?id={{item.createBy.id}}">
        <img src="${ctxStatic}{{item.createBy.photo}}" alt="{{item.createBy.name}}">
      </a>
      <div class="fly-detail-user">
        <a href="${ctx}/home/user?id={{item.createBy.id}}" class="fly-link">
          <cite>{{item.createBy.name}}</cite>
        </a>
      </div>
      <div class="detail-hits">
        <span>{{layui.laytpl.toDateString(item.createDate, 'yyyy-MM-dd HH:mm')}}</span>
      </div>
    </div>
    <div class="detail-body jieda-body photos">
      {{item.content}}
    </div>
    <div class="jieda-reply">
      <span class="jieda-zan {{item.isLike?'zanok':''}}" type="zan"> <i class="iconfont icon-zan"></i> <em>{{item.likeCount ? item.likeCount:0}}</em> </span>
      <span type="reply">
        <i class="iconfont icon-svgmoban53"></i>回复
      </span>
      {{#  if(item.createBy.id == '${sessionScope.user.id}') { }}
      <div class="jieda-admin">
        <span type="del">删除</span>
      </div>
      {{#  }}}
    </div>
  </li>
  {{#  }); }}
  </ul>
</script>

<!-- 加个span消除一下界面布局的BUG -->
<span></span>
</body>
</html>