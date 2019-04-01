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
    <link rel="stylesheet" href="${ctxStatic}/css/jigsaw.css">
    <script src="${ctxStatic}/js/jigsaw.js"></script>
    <script src="${ctxStatic}/jquery/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/layui/res/layui/layui.js" type="text/javascript"></script>
</head>

<body>

<%@include file="common/header.jsp" %>
<div class="layui-container fly-marginTop">
  <div class="fly-panel fly-panel-user" pad20>
    <div class="layui-tab layui-tab-brief" lay-filter="user">
      <ul class="layui-tab-title">
        <li><a href="${ctx}/login/loginIndex">登入</a></li>
        <li class="layui-this">找回密码</li>
      </ul>
      <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
        <div class="layui-tab-item layui-show">
          <div class="layui-form layui-form-pane">
              <div class="layui-form-item">
                <label for="L_email" class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_email" name="email" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux" style="color: red" id="L_email_ver"></div>
              </div>
              <div class="layui-form-item">
                <label for="L_vercode" class="layui-form-label">验证码</label>
                <div class="layui-input-inline">
                  <input type="text" id="L_vercode" name="vercode" required lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid">
                  <input type="button" value="点击获取" class="input-button" id="btn_code">
                  <input type="hidden" id="code">
                  <div class="layui-form-mid layui-word-aux" style="color: red" id="L_code_ver"></div>
                </div>
              </div>
              <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_pass" name="pass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux" style="color: red" id="L_pass_ver"></div>
              </div>
              <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">确认密码</label>
                <div class="layui-input-inline">
                  <input type="password" id="L_repass" name="repass" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux" style="color: red" id="L_repass_ver"></div>
              </div>
              <div class="layui-form-item">
                <button class="layui-btn" id="regsubmit">提交</button>
              </div>
          </div>
        </div>
      </div>
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

  layui.use(['jquery', 'layer', 'laytpl', 'util', 'form', 'fly','element'], function() {
    var laytpl = layui.laytpl;
    var form = layui.form;
    var $ = jQuery = layui.$;
    var fly = layui.fly;
    var element = layui.element;

    $("#btn_code").click(function () {
      var reg=/^\w+@\w+(\.[a-zA-Z]{2,3}){1,2}$/;
      if(reg.test($("#L_email").val())==false){
        $("#L_email_ver").text("Email格式不正确");
        return ;
      }else {
        $.ajax({
          url:"${ctx}/login/getCode",
          type:'POST',
          data:{"emailNum":$("#L_email").val()},
          success:function(r){
            $("#code").val(r.data);
          }
        })
      }
    });

    $("#L_email").focus(function () {
      $("#L_email_ver").text("");
    });
    $("#L_pass").focus(function () {
      $("#L_pass_ver").text("");
    });
    $("#L_repass").focus(function () {
      $("#L_repass_ver").text("");
    });

    $("#regsubmit").click(function () {
      var reg=/^\w+@\w+(\.[a-zA-Z]{2,3}){1,2}$/;
      if(reg.test($("#L_email").val())==false){
        $("#L_email_ver").text("Email格式不正确");
        return false;
      }else if($("#L_pass").val().length<6){
        $("#L_pass_ver").text("密码长度应该大于6位");
        return false;
      }else if($("#L_repass").val()!=$("#L_pass").val()){
        $("#L_repass_ver").text("密码前后不一致");
        return
      }else if($("#code").val()!=$("#L_vercode").val()){
        $("#L_code_ver").text("验证码错误，请重新输入")
        return
      }
      $.ajax({
        url:"${ctx}/login/upadtePaw",
        type:"POST",
        data:{"email":$("#L_email").val(),"password":$("#L_pass").val()},
        success:function(r){
          if (r.data) {
            layer.msg("修改成功！");
            var url = "/login/loginIndex";
            setTimeout("location.href = '" + url + "'",2000);
          }else {
            $("#L_email_ver").text("该邮箱未注册");
          }
        }
      })
    })
  })

</script>
</body>
</html>