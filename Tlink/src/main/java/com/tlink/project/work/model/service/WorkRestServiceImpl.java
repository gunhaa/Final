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

	@Override
	public int insertTable(Map<String, Object> data) {
		return dao.insertTable(data);
	}

	
	
	@Override
	public int updateWorkTitle(Map<String, Object> data) {
		return dao.updateWorkTitle(data);
	}
	@Override
	public int updateDueDate(Map<String, Object> data) {
		return dao.updateDueDate(data);
	}
	@Override
	public int updateWorkState(Map<String, Object> data) {
		return dao.updateWorkState(data);
	}
	@Override
	public int updateWorkPriority(Map<String, Object> data) {
		return dao.updateWorkPriority(data);
	}
	@Override
	public int updateWorkManager(Map<String, Object> data) {
		return dao.updateWorkManager(data);
	}
	@Override
	public int updateParentNo(Map<String, Object> data) {
		return dao.updateParentNo(data);
	}
	

	
	
	
}
