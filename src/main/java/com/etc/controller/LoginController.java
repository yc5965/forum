package com.etc.controller;

import com.etc.common.*;
import com.etc.entity.BsUser;
import com.etc.service.BsUserService;
import com.xiaoleilu.hutool.util.ObjectUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Properties;
import java.util.UUID;

@Controller
@RequestMapping("/login")
public class LoginController {
    @Autowired
    private BsUserService bsUserService;

    @RequestMapping("loginIndex")
    public String loginIndex(){
        return "login";
    }

    @RequestMapping("regIndex")
    public String regIndex(){
        return "reg";
    }

    @RequestMapping("forgetIndex")
    public String forgetIndex(){
        return "forget";
    }


    //获取验证码
    @RequestMapping("getCode")
    @ResponseBody
    public JsonResult getCode(String emailNum){
        JavaMailUtil.receiveMailAccount = emailNum; // 给用户输入的邮箱发送邮件
        try {
            // 1、创建参数配置，用于连接邮箱服务器的参数配置
            Properties props = new Properties();
            // 开启debug调试
            props.setProperty("mail.debug", "true");
            // 发送服务器需要身份验证
            props.setProperty("mail.smtp.auth", "true");
            // 设置右键服务器的主机名
            props.setProperty("mail.host", JavaMailUtil.emailSMTPHost);
            // 发送邮件协议名称
            props.setProperty("mail.transport.protocol", "smtp");
            // 2、根据配置创建会话对象，用于和邮件服务器交互
            Session session = Session.getInstance(props);
            // 设置debug，可以查看详细的发送log
            session.setDebug(true);
            // 3、创建一封邮件
            String code = RandomUtil.getRandom();
            System.out.println("邮箱验证码：" + code);
            String html = HtmlText.html(code);
            MimeMessage message = JavaMailUtil.creatMimeMessage(session, JavaMailUtil.emailAccount,
                    JavaMailUtil.receiveMailAccount, html);

            // 4、根据session获取邮件传输对象
            Transport transport = session.getTransport();
            // 5、使用邮箱账号和密码连接邮箱服务器emailAccount必须与message中的发件人邮箱一致，否则报错
            transport.connect(JavaMailUtil.emailAccount, JavaMailUtil.emailPassword);
            // 6、发送邮件,发送所有收件人地址
            transport.sendMessage(message, message.getAllRecipients());
            // 7、关闭连接
            transport.close();
            //  写入session
            return new JsonResult(code);

        }catch (Exception e) {
            e.printStackTrace();
            return new JsonResult("邮件发送失败");
        }
    }

    @RequestMapping("regUser")
    @ResponseBody
    public JsonResult regUser(BsUser user) {
        BsUser bsUser = bsUserService.findUserByEmail(user.getEmail());
        BsUser user1 = bsUserService.getByName(user.getName());
        if (ObjectUtil.isNotNull(user1)){
            return new JsonResult("昵称");
        }
        else if (ObjectUtil.isNull(bsUser)) {
            user.setDelFlag("0");
            user.setCreateDate(new Date());
            user.setPhoto("/avatar/default/default.jpg");
            user.setId(UUID.randomUUID().toString());
            user.setPassword(EnDecryptUtil.MD5(user.getPassword()));
            user.setUserType("1");
            user.setPhone(null);
            user.setExpireDate(new Date());
            user.setRemarks(null);
            bsUserService.regUser(user);
            return new JsonResult("成功");
        }else {
            return new JsonResult("邮箱");
        }
    }

    @RequestMapping("upadtePaw")
    @ResponseBody
    public JsonResult upadtePaw(BsUser user) {
        int i = bsUserService.updateUserByEmail(user);
        if (i>0) {
            return new JsonResult(true);
        }else {
            return new JsonResult(false);
        }
    }


    // 验证用户登录
    @RequestMapping("/checkLogin")
    @ResponseBody
    public JsonResult checkLogin(BsUser user, String rememberMe, HttpServletRequest request, HttpServletResponse response) throws Exception {
        BsUser checkUser = bsUserService.checkUser(user.getEmail(), user.getPassword());
        if (ObjectUtil.isNotNull(checkUser)) {
            if ("1".equals(rememberMe)) {
                Cookie uemail = new Cookie("uemail",user.getEmail());
                Cookie upwd = new Cookie("upwd", user.getPassword());
                upwd.setMaxAge(3600 * 24 * 7);
                uemail.setMaxAge(3600 * 24 * 7);
                uemail.setPath("/");
                upwd.setPath("/");
                response.addCookie(uemail);
                response.addCookie(upwd);
            } else {
                Cookie uemail = new Cookie("uemail", null);
                Cookie upwd = new Cookie("upwd", null);
                upwd.setMaxAge(0);
                uemail.setMaxAge(0);
                response.addCookie(upwd);
                response.addCookie(uemail);
            }
            // 讲用户添加进session中
            checkUser.setPassword(null);
            request.getSession().setAttribute("user", checkUser);
            return new JsonResult(true);
        } else {
            return new JsonResult(false);
        }
    }


    @RequestMapping("logout")
    public String logout(HttpSession session, HttpServletResponse response) throws IOException {
        BsUser user = (BsUser) session.getAttribute("user");
        if (user!=null) {
            session.removeAttribute("user");
            Cookie uemail = new Cookie("uemail", null);
            Cookie upwd = new Cookie("upwd", null);
            upwd.setMaxAge(0);
            uemail.setMaxAge(0);
            uemail.setPath("/");
            upwd.setPath("/");
            response.addCookie(upwd);
            response.addCookie(uemail);
        }
        return "redirect:/home/index";

    }
}