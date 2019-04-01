package com.etc.entity;

public class Article {
    private String id;
    private String title;
    private String artTime;
    private String introduction;
    private String imageUrl;
    private String content;
    private String pageUrl;
    private String articleType;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getArtTime() {
        return artTime;
    }

    public void setArtTime(String artTime) {
        this.artTime = artTime;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
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

    public String getPageUrl() {
        return pageUrl;
    }

    public void setPageUrl(String pageUrl) {
        this.pageUrl = pageUrl;
    }

    public String getArticleType() {
        return articleType;
    }

    public void setArticleType(String articleType) {
        this.articleType = articleType;
    }

    public Article(String id, String title, String artTime, String introduction, String imageUrl, String content, String pageUrl, String articleType) {
        this.id = id;
        this.title = title;
        this.artTime = artTime;
        this.introduction = introduction;
        this.imageUrl = imageUrl;
        this.content = content;
        this.pageUrl = pageUrl;
        this.articleType = articleType;
    }

    public Article() {
    }
}