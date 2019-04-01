package com.etc.dao;

import com.etc.entity.CjNewsDetail;
import com.etc.entity.CjNewsSrcDict;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CjNewsMapper {

    List<CjNewsSrcDict> findNewsDict();

    List<CjNewsDetail> findPageNewsDetail(@Param("pageStart") Integer pageStart, @Param("pageSize") Integer pageSize, @Param("cjNewsDetail") CjNewsDetail cjNewsDetail);

    Integer findNewsDetailCount(@Param("cjNewsDetail") CjNewsDetail cjNewsDetail);
}
