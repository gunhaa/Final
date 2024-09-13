package com.tlink.project.work.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WorkRestDAO {
	@Autowired private SqlSessionTemplate sqlSession;



	
	public int update(Map<String, Object> data) {
		return  sqlSession.update("workRestMapper.update", data);
		
	}




	public int delete(Map<String, Object> data) {
		return  sqlSession.delete("workRestMapper.delete", data);
	}
}
