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
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping("/caixinWeekly")
public class CaiXinWeeklyController {

    @Autowired
    private CaiXinService caiXinApiService;

    @RequestMapping("weeklyCaixin")
    public String weekly(Model model) {
        return "caixin/weeklyCaixin";
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

    @RequestMapping("weeklyPage")
    @ResponseBody
    public Map<String,Object> weeklyPage(Integer pageNum, Integer pageSize) {
        Integer pageStart = (pageNum - 1) * pageSize;
        Map map=new HashMap<>();
        Integer count = caiXinApiService.getWeeklycount();
        List<WeeklyPeriod> weeklyPeriods = caiXinApiService.getweeklys(pageStart, pageSize);
        map.put("pageCount",count);
        map.put("articles",weeklyPeriods);
        return map;
    }

    @RequestMapping("getWeekly/{id}")
    public String getWeekly(@PathVariable String id, Model model) {
        List<WeeklyArticle> weeklyArticles = caiXinApiService.getWeeklyArts(id);
        List<Dict> weeklyArticles1 = new ArrayList<Dict>();
        List<Dict> weeklyArticles2 = new ArrayList<Dict>();
        List<Dict> weeklyArticles3 = new ArrayList<Dict>();
        List<Dict> futiao = new ArrayList<Dict>();
        Set<String> weeklyArticletype = new HashSet();
        for (WeeklyArticle weeklyArticle : weeklyArticles) {
            if (weeklyArticle.getArticleSign().equals("0")) {
                model.addAttribute("toutiao", weeklyArticle);
            }
            weeklyArticletype.add(weeklyArticle.getArticleType());
        }
        for (String str : weeklyArticletype) {
            List<WeeklyArticle> weeklyArticleList = new ArrayList<>();
            for (WeeklyArticle weeklyArticle : weeklyArticles) {
                if (str.equals(weeklyArticle.getArticleType()) && !(weeklyArticle.getArticleSign().equals("0"))) {
                    weeklyArticleList.add(weeklyArticle);
                }
            }
            if (!(str.equals("头条"))) {
                WeeklyArticle weeklyArticle = weeklyArticleList.get(0);
                if (weeklyArticle.getArticleSign().equals("1")) {
                    weeklyArticles1.add(Dict.create().set("artType", str).set("artList", weeklyArticleList));
                } else if (weeklyArticle.getArticleSign().equals("2")) {
                    weeklyArticles2.add(Dict.create().set("artType", str).set("artList", weeklyArticleList));
                } else if (weeklyArticle.getArticleSign().equals("3")) {
                    weeklyArticles3.add(Dict.create().set("artType", str).set("artList", weeklyArticleList));
                }else if (weeklyArticle.getArticleSign().equals("4")) {
                    futiao.add(Dict.create().set("artType", str).set("artList", weeklyArticleList));
                }
            }
        }
        model.addAttribute("futiao", futiao);
        model.addAttribute("weeklyArticles1", weeklyArticles1);
        model.addAttribute("weeklyArticles2", weeklyArticles2);
        model.addAttribute("weeklyArticles3", weeklyArticles3);
        return "caixin/weekly";
    }

    @RequestMapping("getWeeklyArticle/{id}")
    public String getWeeklyArticle(@PathVariable String id, Model model) {
        WeeklyArticle weeklyArticle = caiXinApiService.findWeeklyArticleById(id);
        model.addAttribute("article", weeklyArticle);
        return "caixin/article";

    }
}
