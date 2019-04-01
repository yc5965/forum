package com.etc.entity;

public class WeeklyArticle {
    private String id;
    private String articleType;
    private String title;
    private String introduction;
    private String artTime;
    private String imageUrl;
    private String content;
    private String articleSign;
    private String pageUrl;
    private String weeklyNum;
    private String weeklyTime;
    private String weeklyTitle;
    private String weeklyImage;
    private String weeklyIssueImage;
    private String weeklySummary;



    public WeeklyArticle() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getArticleType() {
        return articleType;
    }

    public void setArticleType(String articleType) {
        this.articleType = articleType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getArtTime() {
        return artTime;
    }

    public void setArtTime(String artTime) {
        this.artTime = artTime;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getArticleSign() {
        return articleSign;
    }

    public void setArticleSign(String articleSign) {
        this.articleSign = articleSign;
    }

    public String getPageUrl() {
        return pageUrl;
    }

    public void setPageUrl(String pageUrl) {
        this.pageUrl = pageUrl;
    }

    public String getWeeklyNum() {
        return weeklyNum;
    }

    public void setWeeklyNum(String weeklyNum) {
        this.weeklyNum = weeklyNum;
    }

    public String getWeeklyTime() {
        return weeklyTime;
    }

    public void setWeeklyTime(String weeklyTime) {
        this.weeklyTime = weeklyTime;
    }

    public String getWeeklyTitle() {
        return weeklyTitle;
    }

    public void setWeeklyTitle(String weeklyTitle) {
        this.weeklyTitle = weeklyTitle;
    }

    public String getWeeklyImage() {
        return weeklyImage;
    }

    public void setWeeklyImage(String weeklyImage) {
        this.weeklyImage = weeklyImage;
    }

    public String getWeeklyIssueImage() {
        return weeklyIssueImage;
    }

    public void setWeeklyIssueImage(String weeklyIssueImage) {
        this.weeklyIssueImage = weeklyIssueImage;
    }

    public String getWeeklySummary() {
        return weeklySummary;
    }

    public void setWeeklySummary(String weeklySummary) {
        this.weeklySummary = weeklySummary;
    }

    public WeeklyArticle(String id, String articleType, String title, String introduction, String artTime, String imageUrl, String content, String articleSign, String pageUrl, String weeklyNum, String weeklyTime, String weeklyTitle, String weeklyImage, String weeklyIssueImage, String weeklySummary) {
        this.id = id;
        this.articleType = articleType;
        this.title = title;
        this.introduction = introduction;
        this.artTime = artTime;
        this.imageUrl = imageUrl;
        this.content = content;
        this.articleSign = articleSign;
        this.pageUrl = pageUrl;
        this.weeklyNum = weeklyNum;
        this.weeklyTime = weeklyTime;
        this.weeklyTitle = weeklyTitle;
        this.weeklyImage = weeklyImage;
        this.weeklyIssueImage = weeklyIssueImage;
        this.weeklySummary = weeklySummary;
    }
}