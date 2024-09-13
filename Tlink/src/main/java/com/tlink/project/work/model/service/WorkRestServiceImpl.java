package com.tlink.project.work.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tlink.project.work.model.dao.WorkDAO;
import com.tlink.project.work.model.dao.WorkRestDAO;

@Service
public class WorkRestServiceImpl implements WorkRestService{
	
	@Autowired private WorkRestDAO dao;

	@Override @Transactional(rollbackFor=Exception.class)
	public int update(Map<String, Object> data) {
		return dao.update(data);
	}

	@Override  @Transactional(rollbackFor=Exception.class)
	public int delete(Map<String, Object> data) {
		return dao.delete(data);
	}
	

	
	
	
}
