package com.etc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping(value = "/home/personal")
public class PersonalController{

	@RequestMapping(value = {"personalPost"})
	public String personalPost() {
		return "personal/personalPost";
	}

	@RequestMapping(value = {"personalComment"})
	public String personalComment() {
		return "personal/personalComment";
	}

	@RequestMapping(value = {"personalLike"})
	public String personalLike() {
		return "personal/personalLike";
	}

	@RequestMapping(value = {"personalDynamic"})
	public String personalDynamic() {
		return "personal/personalDynamic";
	}

}
