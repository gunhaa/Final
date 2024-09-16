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
	public List<Project> create(Project project) {
		
		int result = dao.create(project);
		
		// 생성된 프로젝트 아이디를 반환
		int projectNo = project.getProjectNo();
		
		List<Project> projectList = new ArrayList<Project>();
		
		if(result > 0) {
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("userNo", project.getManager());
			map.put("projectNo", projectNo);
			
			result = dao.insertUser(map);
			
			// 프로젝트 생성된 경우
			if(result > 0) {
				projectList = mainDAO.selectProjectList(project.getManager());
			}
			
		}
		
		return projectList;
	}
}
