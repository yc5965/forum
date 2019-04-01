package com.etc.controller;


import com.etc.common.JsonResult;
import com.etc.dao.BsUserDynamicMapper;
import com.etc.dao.BsUserLikeMapper;
import com.etc.entity.BsComment;
import com.etc.entity.BsPost;
import com.etc.entity.BsUserDynamic;
import com.etc.entity.BsUserLike;
import com.etc.service.BsCommentService;
import com.etc.service.BsLikeService;
import com.etc.service.BsPostService;
import com.etc.service.BsUserService;
import com.etc.utils.UserUtils;
import com.xiaoleilu.hutool.util.StrUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value = "/bs/bsPersonal")
public class BsPersonalController {
    @Autowired
    private BsPostService bsPostService;
    @Autowired
    private BsLikeService bsLikeViewService;
    @Autowired
    private BsCommentService bsCommentService;
    @Autowired
    private BsUserDynamicMapper bsUserDynamicMapper;
    @Autowired
    private BsUserLikeMapper bsUserLikeMapper;


    @RequestMapping("getPersonalLike")
    @ResponseBody
    public JsonResult getPersonalLike(@RequestParam(defaultValue = "10") Integer pageSize,
                                      @RequestParam(defaultValue = "1") Integer pageNum) {
        Integer pageStart = (pageNum - 1) * pageSize;
        Map<String, Object> info = new HashMap<>();
        List<BsUserLike> infoList = bsUserLikeMapper.findUserLike(UserUtils.getUser().getId(), pageStart, pageSize);
        Integer count = bsUserLikeMapper.findUserLikeCount(UserUtils.getUser().getId());
        for (BsUserLike bsLikeView : infoList) {
            String regex = StrUtil.format("<{}.*src=(.*?)[^>]*?>", "img");
            String content = bsLikeView.getContent().replaceAll(regex, "[图片]");
            bsLikeView.setContent(content);
        }
        info.put("infoList", infoList);
        info.put("count", count);
        return new JsonResult(info);
    }

    @RequestMapping("getPersonalComment")
    @ResponseBody
    public JsonResult getPersonalComment(@RequestParam(defaultValue = "10") Integer pageSize,
                                         @RequestParam(defaultValue = "1") Integer pageNum) {
        Integer pageStart = (pageNum - 1) * pageSize;
        BsComment bsComment = new BsComment();
        bsComment.setCreateBy(UserUtils.getUser());
        List<BsComment> comments = bsCommentService.getUserComment(bsComment.getCreateBy().getId(), pageStart, pageSize);
        Integer count = bsCommentService.findUserCommentCout(bsComment.getCreateBy().getId());
        for (BsComment comment : comments) {
            String regex = StrUtil.format("<{}.*src=(.*?)[^>]*?>", "img");
            String content = comment.getContent().replaceAll(regex, "[图片]");
            comment.setContent(content);
        }
        Map<String, Object> info = new HashMap<>();
        info.put("comments", comments);
        info.put("count", count);
        return new JsonResult(info);
    }

    @RequestMapping("getPersonalDynamic")
    @ResponseBody
    public JsonResult getPersonalDynamic(@RequestParam(defaultValue = "10") Integer pageSize,
                                         @RequestParam(defaultValue = "1") Integer pageNum) {
        Integer pageStart = (pageNum - 1) * pageSize;
        Map<String, Object> info = new HashMap<>();
        List<BsUserDynamic> dynamicLikes = bsUserDynamicMapper.findDynamicLike(UserUtils.getUser().getId(), UserUtils.getUser().getName(), pageStart, pageSize);
        Integer count = bsUserDynamicMapper.findUserDynamicCount(UserUtils.getUser().getId(), UserUtils.getUser().getName()).size();
        for (BsUserDynamic bsUserDynamic : dynamicLikes) {
            String regex = StrUtil.format("<{}.*src=(.*?)[^>]*?>", "img");
            String content = bsUserDynamic.getContent().replaceAll(regex, "[图片]");
            bsUserDynamic.setContent(content);
        }
        info.put("infoList", dynamicLikes);
        info.put("count", count);
        return new JsonResult(info);
    }

    @RequestMapping("getPersonalPost")
    @ResponseBody
    public JsonResult getPersonalPost(@RequestParam(defaultValue = "10") Integer pageSize,
                                      @RequestParam(defaultValue = "1") Integer pageNum) {
        Integer pageStart = (pageNum - 1) * pageSize;
        Map<String, Object> info = new HashMap<>();
        BsPost bsPost = new BsPost();
        bsPost.setCreateBy(UserUtils.getUser());
        List<BsPost> infoList = bsPostService.getUserPosts(bsPost.getCreateBy().getId(), pageStart, pageSize);
        info.put("infoList", infoList);
        Integer count = bsPostService.getUserPostCout(bsPost.getCreateBy().getId());
        info.put("count", count);
        return new JsonResult(info);
    }
}