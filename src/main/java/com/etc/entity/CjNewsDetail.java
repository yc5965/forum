package com.etc.entity;

public class CjNewsDetail {
    private String id;
    private String title;
    private String content;
    private String subContent;
    private String newsDate;
    private String src;
    private String channels;
    private String createDate;

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSubContent() {
        return subContent;
    }

    public void setSubContent(String subContent) {
        this.subContent = subContent;
    }

    public String getNewsDate() {
        return newsDate;
    }

    public void setNewsDate(String newsDate) {
        this.newsDate = newsDate;
    }

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    public String getChannels() {
        return channels;
    }

    public void setChannels(String channels) {
        this.channels = channels;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public CjNewsDetail() {
    }

    public CjNewsDetail(String id, String title, String content, String subContent, String newsDate, String src, String channels, String createDate) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.subContent = subContent;
        this.newsDate = newsDate;
        this.src = src;
        this.channels = channels;
        this.createDate = createDate;
    }

}