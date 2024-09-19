package com.tlink.project.work.model.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.tlink.project.work.model.dto.Work;


public interface WorkRestService {

	int update(Map<String, Object> data);

	int delete(Map<String, Object> data);

	int insertTable(Map<String, Object> data);

	
	int updateWorkTitle(Map<String, Object> data);
	int updateDueDate(Map<String, Object> data);
	int updateWorkState(Map<String, Object> data);
	int updateWorkPriority(Map<String, Object> data);
	int updateWorkManager(Map<String, Object> data);
	int updateParentNo(Map<String, Object> data);

	Work insertStateBy(Map<String, Object> data);

	int insertMywork(Map<String, Object> data);



}
