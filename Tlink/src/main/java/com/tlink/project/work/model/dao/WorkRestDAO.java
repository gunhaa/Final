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




	public int insertTable(Map<String, Object> data) {
		 int result=sqlSession.insert("workRestMapper.insertTable", data);
		 int workNo=sqlSession.selectOne("workRestMapper.selectWorkNo");
		 System.out.println(workNo);
		 return workNo;
	}




	public int updateWorkTitle(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateWorkTitle", data);
	}
	public int updateDueDate(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateDueDate", data);
	}
	public int updateWorkState(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateWorkState", data);
	}
	public int updateWorkPriority(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateWorkPriority", data);
	}
	public int updateWorkManager(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateWorkManager", data);
	}
	public int updateParentNo(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateParentNo", data);
	}
	
}
