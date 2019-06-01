package com.etc.entity;

import java.io.Serializable;
import java.util.Date;

public class BsComment implements Serializable {
    private String id;

    private BsUser createBy;

    private Date createDate;

    private String  createString;

    private String updateBy;

    private Date updateDate;

    private String delFlag;

    private String postId;

    private String remarks;

    private String content;

    private Integer likeCount;

    private BsPost bsPost;

    private String userCommentCount;

    private Integer isLike;   //当前用户是否点赞 1已点赞未点赞

    private static final long serialVersionUID = 1L;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreateString() {
        return createString;
    }

    public void setCreateString(String createString) {
        this.createString = createString;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy == null ? null : updateBy.trim();
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag == null ? null : delFlag.trim();
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId ;
    }

    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }

    public BsPost getBsPost() {
        return bsPost;
    }

    public void setBsPost(BsPost bsPost) {
        this.bsPost = bsPost;
    }

    public String getUserCommentCount() {
        return userCommentCount;
    }

    public void setUserCommentCount(String userCommentCount) {
        this.userCommentCount = userCommentCount;
    }

    public Integer getIsLike() {
        return isLike;
    }

    public void setIsLike(Integer isLike) {
        this.isLike = isLike;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public BsUser getCreateBy() {
        return createBy;
    }

    public void setCreateBy(BsUser createBy) {
        this.createBy = createBy;
    }

    public BsComment(String id, BsUser createBy, Date createDate, String createString, String updateBy, Date updateDate, String delFlag, String postId, String remarks, String content, Integer likeCount, BsPost bsPost, String userCommentCount, Integer isLike) {
        this.id = id;
        this.createBy = createBy;
        this.createDate = createDate;
        this.createString = createString;
        this.updateBy = updateBy;
        this.updateDate = updateDate;
        this.delFlag = delFlag;
        this.postId = postId;
        this.remarks = remarks;
        this.content = content;
        this.likeCount = likeCount;
        this.bsPost = bsPost;
        this.userCommentCount = userCommentCount;
        this.isLike = isLike;
    }

    public BsComment() {
    }
}