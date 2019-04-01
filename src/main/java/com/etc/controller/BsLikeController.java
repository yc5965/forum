/**
 * Copyright &copy; 2016-2018 <a href="http://lowrisk.com.cn">LowRisk</a> All rights reserved.
 */
package com.etc.controller;


import com.etc.common.JsonResult;
import com.etc.entity.BsLike;
import com.etc.service.BsLikeService;
import com.xiaoleilu.hutool.util.StrUtil;
import jdk.nashorn.internal.objects.Global;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 点赞信息Controller
 * @author yc
 * @version 2018-12-21
 */
@Controller
@RequestMapping(value = "/bs/bsLike")
public class BsLikeController {

	@Autowired
	private BsLikeService bsLikeService;
	
	@ModelAttribute
	public BsLike get(@RequestParam(required=false) String id) {
		return null;
	}

	@RequestMapping(value = {"list", ""})
	public String list(BsLike bsLike, HttpServletRequest request, HttpServletResponse response, Model model) {
		return null;
	}

	@RequestMapping(value = "form")
	public String form(BsLike bsLike, Model model) {
		return null;
	}

	@RequestMapping(value = "save")
	public String save(BsLike bsLike, Model model, RedirectAttributes redirectAttributes) {
		return null;
	}

	@RequestMapping(value = "delete")
	public String delete(BsLike bsLike, RedirectAttributes redirectAttributes) {
		return null;
	}

	@RequestMapping(value = "like")
	@ResponseBody
	public JsonResult delComment(@RequestBody BsLike bsLike) {
		if(StrUtil.isEmpty(bsLike.getLikeType()) || StrUtil.isEmpty(bsLike.getRefId())) {
			return new JsonResult(JsonResult.Status.error.name(), 10001, "数据错误，请联系IT部门！");
		}
		return bsLikeService.like(bsLike);
	}
}