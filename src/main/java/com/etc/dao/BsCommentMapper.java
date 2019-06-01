package com.etc.dao;

import com.etc.entity.BsComment;
import com.etc.entity.BsPost;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BsCommentMapper {

    List<BsComment> findComments(@Param("createById") String createById, @Param("pageStart") Integer pageStart,@Param("pageSize") Integer pageSize);

    Integer findUserCommentCout(@Param("createById") String createById);

    List<BsComment> replyItem();

    List<BsComment> findPostComments(@Param("bsComment") BsComment bsComment, @Param("userId") String userId,@Param("pageSize") Integer pageSize,@Param("pageStart") Integer pageStart);

    void deleteByPostId(@Param("postId")String postId);

    List<String> findAllUserByPostId(@Param("postId")String postId);

    Integer getPostCount(@Param("bsComment") BsComment bsComment);

    Integer findTabPosition(@Param("bsComment")BsComment bsComment);

    void delete(@Param("id")String id);

    void insert(@Param("bsComment")BsComment bsComment);

    BsComment get(@Param("id") String id);

    List<BsComment> getCommentList(@Param("pageStart") Integer pageStart,@Param("pageSize") Integer pageSize);

    Integer findListCount();
}