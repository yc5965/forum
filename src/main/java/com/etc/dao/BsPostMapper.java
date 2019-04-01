package com.etc.dao;


import com.etc.entity.BsPost;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface BsPostMapper {

    List<BsPost> findPosts(@Param("createById") String createById,@Param("pageStart") Integer pageStart,@Param("pageSize") Integer pageSize);

    Integer findUserPostCout(@Param("createById")String createById);

    BsPost findDetail(@Param("id")String id, @Param("userId")String userId);

    List<BsPost> getByPostStatus(@Param("postStatus") String postStatus);

    List<BsPost> findPageList(@Param("pageStart") Integer pageStart, @Param("pageSize") Integer pageSize, @Param("postStatus") String postStatus, @Param("postType") String postType ,@Param("sortType") String sortType);

    Integer findPageCount(@Param("postStatus")String postStatus, @Param("postType") String postType);

    List<BsPost> findHostPost(@Param("sortType") String sortType);

    void updatePostLastModifyDate(@Param("id")String id, @Param("LastModifyDate") Date LastModifyDate);

    List<String> findHotTagsBypostType(@Param("postType") String postType);

    void delete(@Param("id")String id);

    BsPost get(@Param("id") String id);

    void update(@Param("bsPost") BsPost bsPost);

    void insert(BsPost bsPost);
}