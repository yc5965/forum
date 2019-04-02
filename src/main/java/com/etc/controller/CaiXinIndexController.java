package com.etc.controller;

import com.etc.entity.Article;
import com.etc.entity.WeeklyArticle;
import com.etc.entity.WeeklyPeriod;
import com.etc.service.CaiXinService;
import com.xiaoleilu.hutool.lang.Dict;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping("/caixinIndex")
public class CaiXinIndexController {

    @Autowired
    private CaiXinService caiXinApiService;

    @RequestMapping("indexCaixin")
    public String index(Model model) {
        return "caixin/indexCaixin";
    }

    @RequestMapping("getArticle/{id}")
    public String findArticleById(@PathVariable String id, Model model) {
        Article article = caiXinApiService.findArticleById(id);
        if (article==null){
            WeeklyArticle weeklyArticle = caiXinApiService.findWeeklyArticleById(id);
            model.addAttribute("article", weeklyArticle);
            return "caixin/article";
        }
        model.addAttribute("article", article);
        return "caixin/article";
    }

    @RequestMapping("indexPage")
    @ResponseBody
    public Map<String,Object> indexPage(Integer pageNum, Integer pageSize) {
        Integer pageStart = (pageNum - 1) * pageSize;
        Map map=new HashMap<>();
        Integer  count = caiXinApiService.getArticleCount();
        List<Article> articles = caiXinApiService.getArticles(pageStart, pageSize);
        map.put("pageCount",count);
        map.put("articles",articles);
        return map;
    }

    @RequestMapping("searchPage")
    @ResponseBody
    public Map<String,Object> searchPage(Integer pageNum, Integer pageSize, String searchVal) {
        Integer pageStart = (pageNum - 1) * pageSize;
        Map map=new HashMap<>();
        Integer count = caiXinApiService.getCountBySearch(searchVal);
        List<Article> articles = caiXinApiService.searchPage(pageStart, pageSize, searchVal);
        map.put("pageCount",count);
        map.put("articles",articles);
        return map;
    }

    @RequestMapping("searchResult")
    public String searchResult(String searchVal ,Model model){
        model.addAttribute("searchVal" ,searchVal);
        return "searchResult";
    }
}
