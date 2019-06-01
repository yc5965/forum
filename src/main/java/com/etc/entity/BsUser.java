package com.etc.entity;

import java.io.Serializable;
import java.util.Date;

public class BsUser implements Serializable {
    private String id;

    private String password;

    private String name;

    private String email;

    private String phone;

    private String userType;

    private String photo;

    private Date createDate;

    private String createString;

    private String remarks;

    private String delFlag;

    private Date expireDate;

    private String  expireString;

    private static final long serialVersionUID = 1L;

    public BsUser() {

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType == null ? null : userType.trim();
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo == null ? null : photo.trim();
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

    public String getExpireString() {
        return expireString;
    }

    public void setExpireString(String expireString) {
        this.expireString = expireString;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag == null ? null : delFlag.trim();
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public BsUser(String id, String password, String name, String email, String phone, String userType, String photo, Date createDate, String remarks, String delFlag, Date expireDate) {
        this.id = id;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.userType = userType;
        this.photo = photo;
        this.createDate = createDate;
        this.remarks = remarks;
        this.delFlag = delFlag;
        this.expireDate = expireDate;
    }

    public BsUser( String name, String email, String userType, Date createDate,   Date expireDate) {
        this.name = name;
        this.email = email;
        this.userType = userType;
        this.createDate = createDate;
        this.expireDate = expireDate;
    }
}