package com.etc.controller;

import com.etc.common.JsonResult;
import com.etc.entity.CjNewsDetail;
import com.etc.service.CjNewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/cj")
public class CjNewsController {

    @Autowired
    private CjNewsService cjNewsService;

    @RequestMapping(value = "newsDict")
    @ResponseBody
    public JsonResult findNewsDict() {
        return cjNewsService.findNewsDict();
    }

    @RequestMapping(value = "newsDetail")
    @ResponseBody
    public JsonResult findPageNewsDetail(@RequestParam(defaultValue = "10") Integer pageSize,
                                         @RequestParam(defaultValue = "1") Integer pageNum,
                                         CjNewsDetail cjNewsDetail) {
        int pageStart = (pageNum - 1) * pageSize;
        return cjNewsService.findPageNewsDetail(pageStart, pageSize, cjNewsDetail);
    }

    @RequestMapping(value = "news")
    public String news() {
        return "caixin/news";
    }

}