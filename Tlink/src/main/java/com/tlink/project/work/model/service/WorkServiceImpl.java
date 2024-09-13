package com.tlink.project.work.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tlink.project.work.model.dao.WorkDAO;

@Service
public class WorkServiceImpl implements WorkService{
	@Autowired private WorkDAO dao;

	@Override
	@Transactional(rollbackFor=Exception.class)
	public void test() {
		dao.test();
	}
	
	
	
	
}
