package com.etc.controller;

import com.etc.entity.BsPost;
import com.etc.entity.BsUser;
import com.etc.service.BsPostService;
import com.etc.service.BsUserService;
import com.etc.utils.UserUtils;
import com.xiaoleilu.hutool.date.DateUtil;
import com.xiaoleilu.hutool.util.ObjectUtil;
import com.xiaoleilu.hutool.util.StrUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;


@Controller
@RequestMapping(value = "/home")
public class HomeController{
	@Autowired
	private BsPostService bsPostService;
	@Autowired
	private BsUserService userService;

   	@RequestMapping("index")
   	public String index(HttpServletRequest request) {
		//获取cookies
		Cookie[] cookies = request.getCookies();
		BsUser user = new BsUser();
		if (null != cookies) {
			for (Cookie cookie : cookies) {
				if ("uemail".equals(cookie.getName())&&StrUtil.isNotBlank(cookie.getValue())) {
					user.setEmail(cookie.getValue());
				}
				if ("upwd".equals(cookie.getName())&&StrUtil.isNotBlank(cookie.getValue())) {
					user.setPassword(cookie.getValue());
				}
			}
		}
		if (StrUtil.isNotBlank(user.getEmail())&&StrUtil.isNotBlank(user.getPassword())){
            BsUser bsUser = userService.checkUser(user.getEmail(), user.getPassword());
            request.getSession().setAttribute("user",bsUser);
            Date date = new Date();
            if (ObjectUtil.isNotNull(bsUser.getExpireDate())&&bsUser.getExpireDate().getTime()<date.getTime()&&bsUser.getUserType().equals("2")){
                userService.updateUserType("1","0");
                bsUser.setUserType("1");
                bsUser.setExpireDate(new Date());
            }
            request.getSession().setAttribute("user",bsUser);
		}
   		return "index";
   	}

	@RequestMapping("add")
	public String add(String id, Model model) {
		BsPost bsPost = bsPostService.get(id);
		model.addAttribute("bsPost", bsPost);
   		return "add";
	}

	@RequestMapping("detail")
	public String detail(String id,String commentId, Model model) {
		BsPost bsPost = bsPostService.findDetail(id);
		if(bsPost == null){
			return "detail-empty";
		}
		model.addAttribute("bsPost", bsPost);
		model.addAttribute("commentId",commentId);
   		return "detail";
	}

	@RequestMapping("user")
	public String user(String id, String name, Model model) {
		if(StrUtil.isNotBlank(id)) {
			BsUser user = userService.getUserById(id);
			model.addAttribute("user", user);
		}else if(StrUtil.isNotBlank(name)){
			BsUser user = userService.getByName(name);
			if (user == null){
				throw new RuntimeException("不存在该用户！");
			}
			model.addAttribute("user", user);
		}
   		return "user";
	}

	@RequestMapping("getAllNames")
	@ResponseBody
	public List<String> getAllNames(){
		List<BsUser> users = userService.findList();
		List<String> usernames = new ArrayList<>();
		for (BsUser user:users) {
			usernames.add(user.getName());
		}
		usernames.sort(new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				Comparator<Object> com = Collator.getInstance(java.util.Locale.CHINA);
				return com.compare(o1, o2);
			}
		});
		usernames.add("所有人");
		return usernames;
	}

	@RequestMapping("pay")
	public String pay(){
   		return "pay";
	}
}
