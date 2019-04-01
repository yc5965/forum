/**
 * Copyright &copy; 2016-2018 <a href="http://lowrisk.com.cn">LowRisk</a> All rights reserved.
 */
package com.etc.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.etc.common.JsonResult;
import com.etc.common.LayUiRes;
import com.etc.entity.BsPost;
import com.etc.service.BsPostService;
import com.etc.utils.UserUtils;
import com.xiaoleilu.hutool.util.StrUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Produces;
import java.io.File;
import java.io.InputStream;
import java.util.*;

/**
 * 文章信息Controller
 *
 * @author yc
 * @version 2018-12-21
 */
@Controller
@RequestMapping(value = "/bs/bsPost")
public class BsPostController{

    @Autowired
    private BsPostService bsPostService;

    @ModelAttribute
    public BsPost get(@RequestParam(required = false) String id) {
       return null;
    }

    @RequestMapping(value = {"list"})
    public String list(BsPost bsPost, HttpServletRequest request, HttpServletResponse response, Model model) {
        return null;
    }


    @RequestMapping(value = "form")
    public String form(BsPost bsPost, Model model) {
        return null;
    }


    @RequestMapping(value = "save")
    public String save(BsPost bsPost, Model model, RedirectAttributes redirectAttributes) {
        return null;
    }

    @RequestMapping(value = "saveAjax")
    @Produces("application/json; charset=utf-8")
    @ResponseBody
    public JSONObject saveAjax(String postType, String title, String id, String content, String postTags, String postStatus, @RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) throws Exception{
        BsPost bsPost=new BsPost();
        bsPost.setId(id);
        bsPost.setPostStatus(postStatus);
        bsPost.setCreateBy(UserUtils.getUser());
        bsPost.setContent(content);
        bsPost.setTitle(title);
        bsPost.setPostType(postType);
        bsPost.setPostTags(postTags);
        bsPost.setLastModifiy(new Date());
        bsPost.setUpdateDate(new Date());
        if (bsPost.getPostStatus().equals("2")){
            String path = request.getServletContext().getRealPath("/upload");
            Random r = new Random();
            List<File> fileList = new ArrayList<File>();
            //对文件名重命名，加个随机数
            String fileName = multipartFile.getOriginalFilename();
            String[] split = fileName.split("\\.");
            fileName = split[0] + r.nextInt(1000);
            fileName = fileName + ".jpg";
            File file = new File(path+"/"+fileName);
            InputStream inputStream = multipartFile.getInputStream();
            FileUtils.copyInputStreamToFile(inputStream, file);
            if(inputStream!=null){
                inputStream.close();
            }
            bsPost.setCoverImg("/upload/"+fileName);
        }
        if (StrUtil.isBlank(bsPost.getId())){
            bsPost.setId(UUID.randomUUID().toString());
            bsPost.setCreateDate(new Date());
            bsPost.setCreateBy(UserUtils.getUser());
            bsPost.setDelFlag("0");
            bsPostService.save(bsPost);
        }else {
            bsPostService.updateBsPost(bsPost);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",bsPost.getId());
        return jsonObject;
    }

    @RequestMapping(value = "getUserPosts")
    @ResponseBody
    public JsonResult getUserPosts(@RequestParam(defaultValue = "20") Integer pageSize,
                                   @RequestParam(defaultValue = "1") Integer pageNum,
                                   String createById, HttpServletRequest request) {
        Integer pageStart = (pageNum - 1) * pageSize;
        List<BsPost> posts = bsPostService.getUserPosts(createById,pageStart,pageSize);
        Integer count = bsPostService.getUserPostCout(createById);

        //置空内容 节省网络流量
        for (BsPost post : posts) {
            post.setContent(null);
        }
        Map<String,Object> postInfo = new HashMap<>();
        postInfo.put("posts",posts);
        postInfo.put("count",count);
        return new JsonResult(postInfo);
    }

    @RequestMapping("getByStatus")
    @ResponseBody
    public JsonResult getByPostStatus(String postStatus) {
        List<BsPost> bsPosts = bsPostService.getByPostStatus(postStatus);
        return new JsonResult(bsPosts);
    }

    @RequestMapping("getPageList")
    @ResponseBody
    public LayUiRes getPageList(Integer pageNum, Integer pageSize, String postStatus, String postType, String sortType) {
        Integer pageStart = (pageNum - 1) * pageSize;
        List<BsPost> bsPosts = bsPostService.findPageList(pageStart, pageSize, postStatus, postType, sortType);
        Integer count = bsPostService.findPageCount(postStatus, postType);
        //置空内容 节省网络流量
        for (BsPost bsPost : bsPosts) {
            bsPost.setContent(null);
        }
        return new LayUiRes(bsPosts, count);
    }

    @RequestMapping("hotPost")
    @ResponseBody
    public JsonResult findHotPost(String sortType) {
        List<BsPost> bsPosts = bsPostService.findHostPost(sortType);
        return new JsonResult(bsPosts);
    }

    @RequestMapping(value = "deletePost")
    @ResponseBody
    public JsonResult deletePost(@RequestBody BsPost bsPost, HttpServletRequest request) {
        bsPostService.deleteAll(bsPost);
        return new JsonResult();
    }

    @RequestMapping(value = "findHotTagsBypostType")
    @ResponseBody
    public JsonResult findHotTagsBypostType(String postType) {
        List<String> tagsList = bsPostService.findHotTagsBypostType(postType);
        List<String> ltags = new ArrayList<String>();
        final Map<String, Integer> tagMap = new HashMap<String, Integer>();
        for (String tags : tagsList) {
            if (StrUtil.isNotBlank(tags)) {
                ltags.addAll(Arrays.asList(tags.split(",")));
            }
        }
        for (String tag : ltags) {
            if (tagMap.containsKey(tag)) {
                tagMap.put(tag, tagMap.get(tag).intValue() + 1);
            } else {
                tagMap.put(tag, 1);
            }
        }
        List<Integer> valuesList = new ArrayList<Integer>(tagMap.values());
        Collections.sort(valuesList);
        Collections.reverse(valuesList);
        List<String> keyList = new ArrayList<String>();
        for (Integer val : valuesList) {
            for (String key : tagMap.keySet()) {
                if (tagMap.get(key).equals(val)) {
                    if (!keyList.contains(key)) {
                        keyList.add(key);
                    }
                }
            }
        }
        return new JsonResult(keyList);
    }

}