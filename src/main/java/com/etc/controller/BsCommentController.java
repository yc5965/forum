/**
 * Copyright &copy; 2016-2018 <a href="http://lowrisk.com.cn">LowRisk</a> All rights reserved.
 */
package com.etc.controller;


import com.etc.common.JsonResult;
import com.etc.entity.BsComment;
import com.etc.service.BsCommentService;
import com.etc.service.BsPostService;
import com.etc.service.BsUserService;
import com.etc.utils.UserUtils;
import com.xiaoleilu.hutool.http.HtmlUtil;
import com.xiaoleilu.hutool.lang.Dict;
import com.xiaoleilu.hutool.lang.Filter;
import com.xiaoleilu.hutool.util.CollectionUtil;
import com.xiaoleilu.hutool.util.ObjectUtil;
import com.xiaoleilu.hutool.util.StrUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 评论信息Controller
 * @author yc
 * @version 2018-12-21
 */
@Controller
@RequestMapping(value = "/bs/bsComment")
public class BsCommentController{

	@Autowired
	private BsCommentService bsCommentService;
	@Autowired
	private BsPostService bsPostService;
	@Autowired
	private BsUserService bsUserService;

	private static final Integer  COMMENT_DEFAULT_LIMIT = 5;
	private static final Integer  COMMENT_DEFAULT_TABNUM = 1;

	@ModelAttribute
	public BsComment get(@RequestParam(required=false) String id) {
		return null;
	}


	@RequestMapping(value = {"list", ""})
	public String list(BsComment bsComment, HttpServletRequest request, HttpServletResponse response, Model model) {
		return null;
	}


	@RequestMapping(value = "form")
	public String form(BsComment bsComment, Model model) {
		return null;
	}

	@RequestMapping(value = "save")
	public String save(BsComment bsComment, Model model, RedirectAttributes redirectAttributes) {
		return null;
	}

	@RequestMapping(value = "delete")
	public String delete(BsComment bsComment, RedirectAttributes redirectAttributes) {
		bsCommentService.delete(bsComment);
		return null;
	}

    @RequestMapping(value = "getUserComment")
    @ResponseBody
    public JsonResult getUserComment(@RequestParam(defaultValue = "20") Integer pageSize,
									 @RequestParam(defaultValue = "1") Integer pageNum,
									 String createById) {
		Integer pageStart = (pageNum - 1) * pageSize;
		List<BsComment> comments = bsCommentService.getUserComment(createById, pageStart, pageSize);
		Integer count = bsCommentService.findUserCommentCout(createById);
		for (BsComment comment : comments) {
			String regex = StrUtil.format("<{}.*src=(.*?)[^>]*?>", "img");
			String content = comment.getContent().replaceAll(regex, "[图片]");
			comment.setContent(content);
		}
		Map<String, Object> commentIfo = new HashMap<>();
		commentIfo.put("comments", comments);
		commentIfo.put("count", count);
		return new JsonResult(commentIfo);
    }

    @RequestMapping("replyItem")
    @ResponseBody
    public JsonResult replyItem(){
		List<BsComment> bsComment = bsCommentService.replyItem();
		return new JsonResult(bsComment);
    }

	@RequestMapping(value = "getPostComment")
	@ResponseBody
	public JsonResult getPostComment(@RequestParam(defaultValue = "1") Integer tabNum, BsComment bsComment) {
		Integer pageStart = (tabNum - 1) * COMMENT_DEFAULT_LIMIT;
		List<BsComment> comments = bsCommentService.getPostComment(bsComment, COMMENT_DEFAULT_LIMIT, pageStart);
		Map<String, Object> commentInfo = new HashMap<>();
		commentInfo.put("comments", comments);
		commentInfo.put("tabNum",tabNum);
		return new JsonResult(commentInfo);
	}


    @RequestMapping(value = "delComment")
    @ResponseBody
    public JsonResult delComment(@RequestBody BsComment bsComment) {
		bsCommentService.delete(bsComment);
		return new JsonResult("操作成功！");
    }

    @RequestMapping(value = "saveComment")
    @ResponseBody
    public JsonResult saveComment(@RequestBody BsComment bsComment) {
		bsCommentService.save(bsComment);
		return new JsonResult("操作成功！");
    }

	@RequestMapping(value = "getCommentByTab")
	@ResponseBody
	public JsonResult getCommentByTab(String postId,String id){
		Integer tabNum = COMMENT_DEFAULT_TABNUM;
		Integer pageStart = 0;
		BsComment bsComment = new BsComment();
		if (StrUtil.isNotEmpty(id)){
			bsComment = bsCommentService.get(id);
		}
		if (ObjectUtil.isNotNull(bsComment)){
			if (StrUtil.isNotBlank(bsComment.getId())){
				Integer sort = bsCommentService.getTabPosition(bsComment);
				tabNum = (sort + COMMENT_DEFAULT_LIMIT -1)/COMMENT_DEFAULT_LIMIT;
			}
		}
		bsComment.setPostId(postId);
		pageStart = (tabNum - 1) * COMMENT_DEFAULT_LIMIT;
		Integer count = bsCommentService.getPostCount(bsComment);
		List<BsComment> comments = bsCommentService.getPostComment(bsComment, COMMENT_DEFAULT_LIMIT, pageStart);
		Map<String,Object> postInfo = new HashMap<>();
		postInfo.put("comments",comments);
		postInfo.put("tabNum",tabNum);
		postInfo.put("count",count);
		return new JsonResult(postInfo);
	}
}