package com.etc.entity;

public class BsUserDynamic {
    private static final long serialVersionUID = 1L;
    private String id;
    private String userId;      //行为人的id
    private String userName;   //行为人的登录名
    private String behaviorType; //行为类型 如点赞，回复等
    private String ownInfoType;  //自己的信息类型
    private String title;  //用户自己的文章或评论
    private String content; //别人回复的评论
    private String message; //别人@自己的内容
    private String createTime; //发生的时间
    private String commentId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getBehaviorType() {
        return behaviorType;
    }

    public void setBehaviorType(String behaviorType) {
        this.behaviorType = behaviorType;
    }

    public String getOwnInfoType() {
        return ownInfoType;
    }

    public void setOwnInfoType(String oenInfoType) {
        this.ownInfoType = oenInfoType;
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

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCommentId() {
        return commentId;
    }

    public void setCommentId(String commentId) {
        this.commentId = commentId;
    }

    public BsUserDynamic(String id, String userId, String userName, String behaviorType, String ownInfoType, String title, String content, String message, String createTime, String commentId) {
        this.id = id;
        this.userId = userId;
        this.userName = userName;
        this.behaviorType = behaviorType;
        this.ownInfoType = ownInfoType;
        this.title = title;
        this.content = content;
        this.message = message;
        this.createTime = createTime;
        this.commentId = commentId;
    }

    public BsUserDynamic() {
    }
}