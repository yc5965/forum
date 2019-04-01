/**
 * Copyright &copy; 2016-2018 <a href="http://lowrisk.com.cn">LowRisk</a> All rights reserved.
 */
package com.etc.service;


import com.etc.dao.BsCommentMapper;
import com.etc.dao.BsPostMapper;
import com.etc.entity.BsComment;
import com.etc.utils.UserUtils;
import com.github.pagehelper.Page;
import com.xiaoleilu.hutool.util.StrUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 评论信息Service
 * @author yc
 * @version 2018-12-21
 */
@Service
@Transactional(readOnly = true)
public class BsCommentService{

	@Autowired
	private BsCommentMapper bsCommentMapper;

	@Autowired
	private BsPostMapper bsPostMapper;

	public BsComment get(String id) {
		return bsCommentMapper.get(id);
	}
	
	public List<BsComment> findList(BsComment bsComment) {
		return null;
	}
	
	public Page<BsComment> findPage(Page<BsComment> page, BsComment bsComment) {
		return null;
	}
	
	@Transactional(readOnly = false)
	public void save(BsComment bsComment) {
		bsComment.setCreateBy(UserUtils.getUser());
		bsComment.setCreateDate(new Date());
		bsComment.setDelFlag("0");
		bsComment.setId(UUID.randomUUID().toString());
		bsCommentMapper.insert(bsComment);
		if(StrUtil.isNotEmpty(bsComment.getPostId())){
			bsPostMapper.updatePostLastModifyDate(bsComment.getPostId(), new Date());
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(BsComment bsComment) {
		bsCommentMapper.delete(bsComment.getId());
	}

    public List<BsComment> getUserComment(String createById, Integer pageStart, Integer pageSize) {
		return bsCommentMapper.findComments(createById,pageStart,pageSize);
    }

    public List<BsComment> replyItem() {
		return bsCommentMapper.replyItem();
    }

    public List<BsComment> getPostComment(BsComment bsComment,Integer pageSize,Integer pageStart) {
		return bsCommentMapper.findPostComments(bsComment, UserUtils.getUser().getId(),pageSize,pageStart);
    }

	@Transactional(readOnly = false)
	public void delete(String postId) {

	}

    public List<String> getAllUserByPostId(String postId) {
		return null;
    }

	public Integer findUserCommentCout(String createById) {
		return bsCommentMapper.findUserCommentCout(createById);
	}

	public Integer getPostCount(BsComment bsComment) {
		return bsCommentMapper.getPostCount(bsComment);
	}

	public Integer getTabPosition(BsComment bsComment) {
		return bsCommentMapper.findTabPosition(bsComment);
	}
}