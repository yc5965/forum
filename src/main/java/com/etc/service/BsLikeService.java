/**
 * Copyright &copy; 2016-2018 <a href="http://lowrisk.com.cn">LowRisk</a> All rights reserved.
 */
package com.etc.service;

import com.etc.common.JsonResult;
import com.etc.dao.BsLikeMapper;
import com.etc.entity.BsLike;
import com.etc.utils.UserUtils;
import com.github.pagehelper.Page;
import com.xiaoleilu.hutool.lang.Dict;
import com.xiaoleilu.hutool.util.CollectionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 点赞信息Service
 * @author yc
 * @version 2018-12-21
 */
@Service
@Transactional(readOnly = true)
public class BsLikeService{
	@Autowired
	private BsLikeMapper bsLikeMapper;

	public BsLike get(String id) {
		return null;
	}
	
	public List<BsLike> findList(BsLike bsLike) {
		return null;
	}
	
	public Page<BsLike> findPage(Page<BsLike> page, BsLike bsLike) {
		return null;
	}
	
	@Transactional(readOnly = false)
	public void save(BsLike bsLike) {
		bsLikeMapper.insert(bsLike);
	}
	
	@Transactional(readOnly = false)
	public void delete(BsLike bsLike) {
		bsLikeMapper.delete(bsLike);
	}

	@Transactional(readOnly = false)
    public JsonResult like(BsLike bsLike) {
		bsLike.setCreateBy(UserUtils.getUser());
		List<BsLike> bsLikes = bsLikeMapper.findList(bsLike);
		Dict data = Dict.create();
		if(CollectionUtil.isEmpty(bsLikes)) {
			//点赞行为
			bsLike.setId(UUID.randomUUID().toString());
			bsLike.setCreateDate(new Date());
			bsLike.setDelFlag("0");
			bsLike.setUpdateDate(new Date());
			save(bsLike);
			data.set("likeStatus", 1);
		}else{
			//取消赞行为
			for (BsLike like:bsLikes) {
				bsLike.setUpdateDate(new Date());
				delete(like);
			}
			data.set("likeStatus", 0);
		}
		bsLike.setCreateBy(null);
		List<BsLike> likes = bsLikeMapper.findList(bsLike);
		data.set("likeCount", likes.size());
		return new JsonResult(data);
    }
}