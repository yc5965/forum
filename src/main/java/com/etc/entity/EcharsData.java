package com.etc.entity;

public class EcharsData {

    private Integer count;
    private String data;

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public EcharsData() {
        super();
    }

    public EcharsData(Integer count, String data) {
        this.count = count;
        this.data = data;
    }
}