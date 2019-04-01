package com.etc.dao;

import com.etc.entity.BsUserDynamic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BsUserDynamicMapper {
    List<BsUserDynamic> findDynamicLike(@Param("uId") String uId, @Param("uName") String uName, @Param("pageStart") Integer pageStart, @Param("pageSize") Integer pageSize);

    List<BsUserDynamic> findUserDynamicCount(@Param("uId") String uId, @Param("uName") String uName);
}
