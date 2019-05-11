package com.etc.controller;

import com.etc.entity.BsPost;
import com.etc.entity.BsUser;
import com.etc.service.BsPostService;
import com.etc.service.BsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
    @Autowired
    private BsUserService bsUserService;

    @Autowired
    private BsPostService bsPostService;


    @RequestMapping("index")
    public String adminIndex(){
        return "admin/index";
    }

    @RequestMapping("test")
    public String tes(){
        return "admin/404";
    }


    @RequestMapping(value = "findListUser")
    @ResponseBody
    public Map findListUser(Integer page,Integer limit , HttpServletRequest request) {

        Integer pageStart = (page - 1) * limit;
        List<BsUser> users = bsUserService.findListUser(pageStart,limit);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", bsUserService.findList().size());
        result.put("data", users);
        return result;
    }

    @RequestMapping(value = "getPostList")
    @ResponseBody
    public Map getPostList(Integer page,Integer limit , HttpServletRequest request) {

        Integer pageStart = (page - 1) * limit;
        List<BsPost> bsPost = bsPostService.getPostList(pageStart,limit);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", bsPostService.findListCount());
        result.put("data", bsPost);
        return result;
    }

    @RequestMapping("userList")
    public String userList(){
        return  "admin/userList";
    }
}
