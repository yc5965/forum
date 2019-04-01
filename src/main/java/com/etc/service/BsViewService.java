/**
 * Copyright &copy; 2016-2018 <a href="http://lowrisk.com.cn">LowRisk</a> All rights reserved.
 */
package com.etc.service;

import com.etc.entity.BsView;
import com.github.pagehelper.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 文章查看记录Service
 * @author yc
 * @version 2018-12-21
 */
@Service
@Transactional(readOnly = true)
public class BsViewService {

	public BsView get(String id) {
		return null;
	}
	
	public List<BsView> findList(BsView bsView) {
		return null;
	}
	
	public Page<BsView> findPage(Page<BsView> page, BsView bsView) {
		return null;
	}
	
	@Transactional(readOnly = false)
	public void save(BsView bsView) {

	}
	
	@Transactional(readOnly = false)
	public void delete(BsView bsView) {

	}
	
}