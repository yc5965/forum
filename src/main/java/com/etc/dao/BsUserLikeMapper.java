package com.etc.dao;

import com.etc.entity.BsUserLike;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BsUserLikeMapper {

    List<BsUserLike> findUserLike(@Param("uId") String uId, @Param("pageStart") Integer pageStart, @Param("pageSize") Integer pageSize);

    Integer findUserLikeCount(@Param("uId") String uId);
}
