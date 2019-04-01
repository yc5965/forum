package com.etc.service;


import com.etc.dao.PomsMapper;
import com.etc.entity.Article;
import com.etc.entity.WeeklyArticle;
import com.etc.entity.WeeklyPeriod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CaiXinService {
    @Autowired
    private PomsMapper pomsMapper;

    public List<Article> getArticles(Integer pageStart, Integer pageSize) {
        return pomsMapper.getArticles(pageStart, pageSize);
    }

    public Article findArticleById(String id) {
        return pomsMapper.findArticleById(id);
    }

    public Integer getArticleCount() {
        return pomsMapper.getArticleCount();
    }

    public List<WeeklyPeriod> getweeklys(Integer pageStart, Integer pageSize) {
        return pomsMapper.getweeklys(pageStart, pageSize);
    }

    public Integer getWeeklycount() {
        return pomsMapper.getWeeklycount();
    }

    public List<WeeklyArticle> getWeeklyArts(String id) {
        return pomsMapper.getWeeklyArts(id);
    }

    public WeeklyArticle findWeeklyArticleById(String id) {
        return pomsMapper.findWeeklyArticleById(id);
    }

    public Integer getCountBySearch(String searVal) {
        return pomsMapper.getCountBySearch(searVal);
    }

    public List<Article> searchPage(Integer pageStart, Integer pageSize, String searchVal) {
        return pomsMapper.searchPage(pageStart,pageSize,searchVal);
    }
}
