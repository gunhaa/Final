package com.tlink.project.project.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.project.model.dto.Project;

@Repository
public class ProjectDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int create(Project project) {
		return sqlSession.insert("projectMapper.create", project);
	}

	// user-project insert
	public int insertUser(Map<String, Object> map) {
		return sqlSession.insert("projectMapper.insertUser", map);
	}

	// 자동 완성
	public List<Project> autocomplete(Map<String, Object> map) {
		return sqlSession.selectList("projectMapper.autocomplete", map);
	}

	public int deleteProject(int projectNo) {
		return sqlSession.delete("projectMapper.deleteProject", projectNo);
	}

	public int deleteUserProject(int projectNo) {
		return sqlSession.delete("projectMapper.deleteUserProject", projectNo);
	}


}
