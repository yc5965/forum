package com.etc.entity;

public class CjNewsSrcDict {
    private String src;
    private String srcName;
    private String des;
    private String channel;
    private String channelName;
    private String sort;

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getSrcName() {
        return srcName;
    }

    public void setSrcName(String srcName) {
        this.srcName = srcName;
    }

    public String getChannelName() {
        return channelName;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public CjNewsSrcDict() {
    }

    public CjNewsSrcDict(String src, String srcName, String des, String channel, String channelName, String sort) {
        this.src = src;
        this.srcName = srcName;
        this.des = des;
        this.channel = channel;
        this.channelName = channelName;
        this.sort = sort;
    }
}