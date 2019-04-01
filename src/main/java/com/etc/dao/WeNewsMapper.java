package com.etc.dao;

import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WeNewsMapper {

    List<JSONObject> findList();

    JSONObject findDetail(@Param("articleId") String articleId);
}
