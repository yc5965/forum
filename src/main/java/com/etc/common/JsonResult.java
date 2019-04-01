package com.etc.common;

import com.alibaba.fastjson.JSON;

public class JsonResult {

	public enum Status {
		ok, error
	}

	private String status = Status.ok.name();
	private Integer errorCode;
	private String errorMsg;
	private Object data;
	private Integer count;
	
	public JsonResult(){}
	
	public JsonResult(Object data){
		this.data = data;
	}
	
	public JsonResult(String status, Integer errorCode, String errorMsg) {
		this.status = status;
		this.errorCode = errorCode;
		this.errorMsg = errorMsg;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(Integer errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
	
	public String toJsonString() {
		return JSON.toJSONString(this);
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public JsonResult(Integer count, Object data) {
		this.count = count;
		this.data = data;
	}

}
