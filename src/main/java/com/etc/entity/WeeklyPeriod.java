package com.etc.entity;

public class WeeklyPeriod {
    private String  id;
    private String  weeklyNum;
    private String  weeklyTime;
    private String  weeklyTitle;
    private String  weeklySummary;
    private String  weeklyImage;
    private String  weeklyIssueImage;

    public WeeklyPeriod(String id, String weeklyNum, String weeklyTime, String weeklyTitle, String weeklySummary, String weeklyImage, String weeklyIssueImage) {
        this.id = id;
        this.weeklyNum = weeklyNum;
        this.weeklyTime = weeklyTime;
        this.weeklyTitle = weeklyTitle;
        this.weeklySummary = weeklySummary;
        this.weeklyImage = weeklyImage;
        this.weeklyIssueImage = weeklyIssueImage;
    }

    public WeeklyPeriod() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getWeeklySummary() {
        return weeklySummary;
    }

    public void setWeeklySummary(String weeklySummary) {
        this.weeklySummary = weeklySummary;
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
}