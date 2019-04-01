package com.etc.controller;

import com.etc.dao.ZzmyzMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/zzmyz")
public class ZZMYZController {

    @Autowired
    private ZzmyzMapper zzmyzMapper;

    @RequestMapping("detail/{id}")
    public String findArticleById(@PathVariable String id, Model model) {
        model.addAttribute("article", zzmyzMapper.findDetail(id));
        return "zzmyz/detail";
    }
}
