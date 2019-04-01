package com.etc.entity;



public class BsUserLike{
    private static final long serialVersionUID = 1L;
    private String id;
    private String content;
    private String createTime;
    private String likeCount;
    private String commentId;
    private String likeType;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(String likeCount) {
        this.likeCount = likeCount;
    }

    public String getCommentId() {
        return commentId;
    }

    public void setCommentId(String commentId) {
        this.commentId = commentId;
    }

    public String getLikeType() {
        return likeType;
    }

    public void setLikeType(String likeType) {
        this.likeType = likeType;
    }

    public BsUserLike(String id, String content, String createTime, String likeCount, String commentId, String likeType) {
        this.id = id;
        this.content = content;
        this.createTime = createTime;
        this.likeCount = likeCount;
        this.commentId = commentId;
        this.likeType = likeType;
    }
    public BsUserLike() {
    }
}