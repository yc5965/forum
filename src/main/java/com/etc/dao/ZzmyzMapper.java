package com.etc.dao;

import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.annotations.Param;

public interface ZzmyzMapper {

    JSONObject findDetail(@Param("articleId") String articleId);

}
