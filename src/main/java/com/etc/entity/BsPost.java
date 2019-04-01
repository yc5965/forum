package com.etc.entity;

import java.io.Serializable;
import java.util.Date;

public class BsPost implements Serializable {
    private String id;

    private BsUser createBy;

    private Date createDate;

    private String updateBy;

    private Date updateDate;

    private String delFlag;

    private String title;

    private String postType;

    private String postTags;

    private String coverImg;

    private Date lastModifiy;

    private String postStatus;

    private Integer sort;

    private String remarks;

    private String content;

    private Integer commentCount;   //评论数量
    private Integer likeCount; //点赞数量
    private Integer viewCount; //查看数量
    private String postTypeLabel;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getPostType() {
        return postType;
    }

    public void setPostType(String postType) {
        this.postType = postType == null ? null : postType.trim();
    }

    public String getPostTags() {
        return postTags;
    }

    public void setPostTags(String postTags) {
        this.postTags = postTags == null ? null : postTags.trim();
    }

    public String getCoverImg() {
        return coverImg;
    }

    public void setCoverImg(String coverImg) {
        this.coverImg = coverImg == null ? null : coverImg.trim();
    }

    public Date getLastModifiy() {
        return lastModifiy;
    }

    public void setLastModifiy(Date lastModifiy) {
        this.lastModifiy = lastModifiy;
    }

    public String getPostStatus() {
        return postStatus;
    }

    public void setPostStatus(String postStatus) {
        this.postStatus = postStatus == null ? null : postStatus.trim();
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(Integer commentCount) {
        this.commentCount = commentCount;
    }

    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    public String getPostTypeLabel() {
        return postTypeLabel;
    }

    public void setPostTypeLabel(String postTypeLabel) {
        this.postTypeLabel = postTypeLabel;
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

    public BsPost(String id, BsUser createBy, Date createDate, String updateBy, Date updateDate, String delFlag, String title, String postType, String postTags, String coverImg, Date lastModifiy, String postStatus, Integer sort, String remarks, String content, Integer commentCount, Integer likeCount, Integer viewCount, String postTypeLabel, Integer isLike) {
        this.id = id;
        this.createBy = createBy;
        this.createDate = createDate;
        this.updateBy = updateBy;
        this.updateDate = updateDate;
        this.delFlag = delFlag;
        this.title = title;
        this.postType = postType;
        this.postTags = postTags;
        this.coverImg = coverImg;
        this.lastModifiy = lastModifiy;
        this.postStatus = postStatus;
        this.sort = sort;
        this.remarks = remarks;
        this.content = content;
        this.commentCount = commentCount;
        this.likeCount = likeCount;
        this.viewCount = viewCount;
        this.postTypeLabel = postTypeLabel;
        this.isLike = isLike;
    }

    public BsPost() {
    }
}