package com.etc.controller;

import com.etc.entity.*;
import com.etc.service.BsCommentService;
import com.etc.service.BsPostService;
import com.etc.service.BsUserService;
import com.etc.service.BsViewService;
import com.xiaoleilu.hutool.date.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
    @Autowired
    private BsUserService bsUserService;

    @Autowired
    private BsPostService bsPostService;

    @Autowired
    private BsCommentService bsCommentService;

    @Autowired
    private BsViewService bsViewService;


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

        for (BsUser user :users){
            String create = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(user.getCreateDate());
            user.setCreateString(create);
            if(user.getExpireDate()!=null) {
                String expireString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(user.getExpireDate());
                user.setExpireString(expireString);
            }
        }
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
        List<BsPost> bsPosts = bsPostService.getPostList(pageStart,limit);
        for (BsPost bsPost :bsPosts){
            String result = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(bsPost.getCreateDate());
            bsPost.setCreateString(result);
        }
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", bsPostService.findListCount());
        result.put("data", bsPosts);
        return result;
    }

    @RequestMapping(value = "findhotPost")
    @ResponseBody
    public Map findhotPost(Integer page,Integer limit , HttpServletRequest request) {

        Integer pageStart = (page - 1) * limit;
        List<BsPost> bsPosts = bsPostService.getAdminPostList(pageStart,limit);
        for (BsPost bsPost :bsPosts){
            String result = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(bsPost.getCreateDate());
            bsPost.setCreateString(result);
        }
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", bsPostService.findHostListCount());
        result.put("data", bsPosts);
        return result;
    }

    @RequestMapping(value = "getCommentList")
    @ResponseBody
    public Map getCommentList(Integer page,Integer limit , HttpServletRequest request) {

        Integer pageStart = (page - 1) * limit;
        List<BsComment> bsComments = bsCommentService.getCommentList(pageStart,limit);
        for (BsComment comment :bsComments){
            String result = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(comment.getCreateDate());
            comment.setCreateString(result);
        }
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", bsCommentService.findListCount());
        result.put("data", bsComments);
        return result;
    }

    @RequestMapping("userList")
    public String userList(){
        return  "admin/userList";
    }

    @RequestMapping(value = "getEchartsData")
    @ResponseBody
    public Map getEchartsData() {
        List<EcharsData> zViews = bsViewService.getzData();
        ArrayList<Integer> zViewsList = new ArrayList<>();
        for (int i=0;i<24;i++) {
            Integer zViewsNumber=0;
            for (EcharsData echarsData:zViews) {
                String number=new String();
                if(i<10){
                    number="0"+i;
                }else {
                    number=i+"";
                }
                if (number.equals(echarsData.getData())){
                    zViewsNumber=echarsData.getCount();
                }
            }
            zViewsList.add(zViewsNumber);
        }


        List<EcharsData> sViews = bsViewService.getsData();
        ArrayList<Integer> sViewsList = new ArrayList<>();

        for (int i=0;i<4;i++) {
            Integer sViewsNumber=0;
            for (EcharsData echarsData:sViews) {
                String number=i+"";
                if (number.equals(echarsData.getData())){
                    sViewsNumber=echarsData.getCount();
                }
            }
            sViewsList.add(sViewsNumber);
        }

        List<EcharsData> vUsers = bsUserService.getvData();
        ArrayList<Integer> vUsersList = new ArrayList<>();

        ArrayList<String> pastDaysList = new ArrayList<>();
        for (int i = 7; i >0; i--) {
            pastDaysList.add(getPastDate(i));
            Integer vUsersNumber=0;
            for (EcharsData echarsData:vUsers){
                if(getPastDate(i).indexOf(echarsData.getData())!=-1){
                    vUsersNumber=echarsData.getCount();
                }
            }
            vUsersList.add(vUsersNumber);
        }
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("zData", zViewsList);
        result.put("sData", sViewsList);
        result.put("vData", vUsersList);
        result.put("vDate",pastDaysList);
        return result;
    }
    public static String getPastDate(int past) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - past);
        Date today = calendar.getTime();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String result = format.format(today);
        return result;
    }
}
