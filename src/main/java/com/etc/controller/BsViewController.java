/**
 * Copyright &copy; 2016-2018 <a href="http://lowrisk.com.cn">LowRisk</a> All rights reserved.
 */
package com.etc.controller;


import com.etc.entity.BsView;
import com.etc.service.BsViewService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 文章查看记录Controller
 * @author yc
 * @version 2018-12-21
 */
@Controller
@RequestMapping(value = "/bs/bsView")
public class BsViewController {

	@Autowired
	private BsViewService bsViewService;
	
	@ModelAttribute
	public BsView get(@RequestParam(required=false) String id) {
		return null;
	}

	@RequestMapping(value = {"list", ""})
	public String list(BsView bsView, HttpServletRequest request, HttpServletResponse response, Model model) {
		return null;
	}

	@RequestMapping(value = "form")
	public String form(BsView bsView, Model model) {
		return null;
	}

	@RequestMapping(value = "save")
	public String save(BsView bsView, Model model, RedirectAttributes redirectAttributes) {
		return null;
	}

	@RequestMapping(value = "delete")
	public String delete(BsView bsView, RedirectAttributes redirectAttributes) {
		return null;
	}

}