package com.tlink.project.project.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tlink.project.main.model.dao.MainDAO;
import com.tlink.project.myPage.model.dao.MyPageDAO;
import com.tlink.project.project.model.dao.ProjectDAO;
import com.tlink.project.project.model.dto.Project;

@Service
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	private ProjectDAO dao;
	
	@Autowired
	private MainDAO mainDAO;

	// 프로젝트 생성
	@Override
	public int create(Project project) {
		
		int result = dao.create(project);
		
		// 생성된 프로젝트 아이디를 반환
		int projectNo = project.getProjectNo();
		
		
		if(result > 0) {
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("userNo", project.getManager());
			map.put("projectNo", projectNo);
			
			result = dao.insertUser(map);
			
		}
		
		return result;
	}

	@Override
	public List<Project> autocomplete(Map<String, Object> map) {
		return dao.autocomplete(map);
	}

	// 프로젝트 삭제
	@Override
	public int deleteProject(int projectNo) {
		int result = dao.deleteProject(projectNo);
		
		if(result > 0) result = dao.deleteUserProject(projectNo); 
		
		return result;
	}


}
