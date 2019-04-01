package com.etc.controller;

import com.etc.dao.WeNewsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/wenews")
public class WeNewsController {

    @Autowired
    private WeNewsMapper weNewsMapper;

    @RequestMapping("index")
    public String index(Model model) {
        model.addAttribute("list", weNewsMapper.findList());
        return "wenews/index";
    }

    @RequestMapping("detail/{id}")
    public String findArticleById(@PathVariable String id, Model model) {
        model.addAttribute("article", weNewsMapper.findDetail(id));
        return "wenews/detail";
    }
}
