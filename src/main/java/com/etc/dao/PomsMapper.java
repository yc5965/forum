package com.etc.dao;

import com.etc.entity.Article;
import com.etc.entity.WeeklyArticle;
import com.etc.entity.WeeklyPeriod;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface PomsMapper {
    @Select("select a.id AS id, a.article_time AS artTime,a.article_title AS title,a.article_introduction AS introduction from  caixin_article a ORDER BY  a.article_time DESC LIMIT #{pageStart},#{pageSize}")
    List<Article> getArticles(@Param("pageStart") Integer pageStart, @Param("pageSize") Integer pageSize);

    @Select("select a.id As id,a.article_title AS title,a.article_time AS artTime,a.article_introduction AS introduction,a.image_url AS imageUrl, a.article_content AS content,a.page_url AS pageUrl FROM caixin_article a WHERE a.id=#{id}")
    Article findArticleById(@Param("id") String id);

    @Select("select count(*) As artCount from caixin_article")
    Integer getArticleCount();

    @Select("select a.id AS id, a.weekly_num AS weeklyNum,a.weekly_time AS weeklyTime,a.weekly_title AS weeklyTitle,a.weekly_image AS weeklyImage from  caixin_weekly_period a ORDER BY  a.weekly_time DESC LIMIT #{pageStart},#{pageSize}")
    List<WeeklyPeriod> getweeklys(@Param("pageStart") Integer pageStart, @Param("pageSize") Integer pageSize);

    @Select("select count(*) As weeklyCount from caixin_weekly_period")
    Integer getWeeklycount();

    @Select("select a.id AS id , a.article_type AS articleType, a.article_title AS title, a.article_summary AS introduction,a.article_sign AS articleSign, b.weekly_num AS weeklyNum,b.weekly_time AS weeklyTime,b.weekly_title AS weeklyTitle ,b.weekly_image AS weeklyImage,b.weekly_issue_image AS weeklyIssueImage, b.weekly_summary AS weeklySummary from caixin_weekly_article a left join caixin_weekly_period b ON a.period_id = b.id WHERE a.period_id=#{id} ")
    List<WeeklyArticle> getWeeklyArts(@Param("id") String id);

    @Select("select a.id As id,a.article_type AS articleType,a.article_title AS title, a.article_summary AS introduction,a.article_sign AS articleSign,a.article_time AS artTime,a.article_image AS imageUrl,a.article_content AS content,a.article_url AS pageUrl FROM caixin_weekly_article a WHERE a.id=#{id}")
    WeeklyArticle findWeeklyArticleById(@Param("id") String id);

    Integer getCountBySearch(@Param("searchVal") String searVal);

    List<Article> searchPage(@Param("pageStart") Integer pageStart, @Param("pageSize") Integer pageSize, @Param("searchVal") String searchVal);
}
