package com.etc.dao;

import com.etc.entity.BsLike;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BsLikeMapper {

    int updateByPrimaryKeySelective(BsLike record);

    int updateByPrimaryKeyWithBLOBs(BsLike record);

    int updateByPrimaryKey(BsLike record);

    List<BsLike> findList(BsLike bsLike);

    void insert(BsLike bsLike);

    void delete(BsLike bsLike);
}