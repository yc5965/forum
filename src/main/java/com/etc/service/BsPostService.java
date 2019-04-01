/**
 * Copyright &copy; 2016-2018 <a href="http://lowrisk.com.cn">LowRisk</a> All rights reserved.
 */
package com.etc.service;


import com.etc.dao.BsCommentMapper;
import com.etc.dao.BsPostMapper;
import com.etc.entity.BsPost;
import com.etc.entity.BsView;
import com.etc.utils.UserUtils;
import com.github.pagehelper.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * 文章信息Service
 * @author yc
 * @version 2018-12-21
 */
@Service
@Transactional(readOnly = true)
public class BsPostService {

	@Autowired
	private BsViewService bsViewService;

	@Autowired
	private BsPostMapper bsPostMapper;

	@Autowired
	private BsCommentMapper bsCommentMapper;

	public BsPost get(String id) {
		return bsPostMapper.get(id);
	}
	
	public List<BsPost> findList(BsPost bsPost) {
		return null;
	}
	
	public Page<BsPost> findPage(Page<BsPost> page, BsPost bsPost) {
		return null;
	}
	
	@Transactional(readOnly = false)
	public void save(BsPost bsPost) {
		bsPostMapper.insert(bsPost);
	}
	
	@Transactional(readOnly = false)
	public void delete(BsPost bsPost) {
		bsPostMapper.delete(bsPost.getId());
	}

    public List<BsPost> getByPostStatus(String postStatus) {
		return  bsPostMapper.getByPostStatus(postStatus);
    }

	public List<BsPost> findPageList(Integer pageStart, Integer pageSize, String postStatus, String postType, String sortType) {
		return bsPostMapper.findPageList(pageStart,pageSize,postStatus,postType, sortType);
	}

    public List<BsPost> getUserPosts(String createById, Integer pageStart,Integer pageSize) {
		return bsPostMapper.findPosts(createById,pageStart,pageSize);
    }

	@Transactional(readOnly = false)
	public BsPost findDetail(String id) {
		BsPost bsPost = bsPostMapper.findDetail(id, UserUtils.getUser().getId());
		try{
			BsView bv = new BsView();
			bv.setCreateBy(UserUtils.getUser());
			bv.setPostId(bsPost.getId());
			bsViewService.save(bv);
		}catch (Exception e){
			e.printStackTrace();
		}
		return bsPost;
	}

	public List<BsPost> findHostPost(String sortType) {
		return bsPostMapper.findHostPost(sortType);
	}

	@Transactional(readOnly = false)
	public void deleteAll(BsPost bsPost) {
		//删除评论表相关信息
		bsCommentMapper.deleteByPostId(bsPost.getId());
		delete(bsPost);
	}

	public Integer findPageCount(String postStatus, String postType) {

		return bsPostMapper.findPageCount(postStatus, postType);
	}

    public List<String> findHotTagsBypostType(String postType) {
		return bsPostMapper.findHotTagsBypostType(postType);
    }

	public Integer getUserPostCout(String createById) {
		return bsPostMapper.findUserPostCout(createById);
	}

	@Transactional(readOnly = false)
    public void updateBsPost(BsPost bsPost) {
		bsPostMapper.update(bsPost);
    }
}