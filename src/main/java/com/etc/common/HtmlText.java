package com.etc.common;

public class HtmlText {
	//  返回页面Html携带的6位随机码
	public static String html(String code) {

		String html = "Email地址验证<br/>" +
				"这封邮件是乐瑞社区发送的。<br/>" +
				"你收到这封邮件是乐瑞社区进行新用户注册。<br/>" +
				"账号激活声明<br/>" +
				"你只将下面验证码输入提示框即可：<h3 style='color:red;'>" + code + "</h3><br/>";
		return html;
	}
}