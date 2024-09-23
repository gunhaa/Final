package com.tlink.project.work.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.work.model.dto.Todo;
import com.tlink.project.work.model.dto.Work;

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
		 int workNo=0;
		 if(result !=0) { workNo=sqlSession.selectOne("workRestMapper.selectWorkNo"); }
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




	public int insertMywork(Map<String, Object> data) {
		 int result=sqlSession.insert("workRestMapper.insertMywork", data);
		 int workNo=0;
		 if(result !=0) { workNo=sqlSession.selectOne("workRestMapper.selectWorkNo"); }
		 System.out.println(workNo);
		 return workNo;
	}
	
	
	
	


	public Map<Integer, Object> managerByMList(Map<String, Object> data) {
		List<Integer> intList = new ArrayList<>();
		intList=sqlSession.selectList("workRestMapper.selectManager", data);
		
		Map<Integer, Object> map=new HashMap<>();
		for(int managerNo : intList){
			List<Work> wList=sqlSession.selectList("workRestMapper.selectManagerByWork", managerNo);
			map.put(managerNo, wList);
		}
		
		return map;
	}




	public Map<Integer, Object> projectByPList(Map<String, Object> data) {
		List<Integer> intList = new ArrayList<>();
		intList=sqlSession.selectList("workRestMapper.selectProject", data);
		
		Map<Integer, Object> map=new HashMap<>();
		for(int projectNo : intList){
			List<Work> wList=sqlSession.selectList("workRestMapper.selectProjectByWork", projectNo);
			map.put(projectNo, wList);
		}
		
		return map;
	}


	
	
	

	public Work insertStateBy(Map<String, Object> data) {
		 int result=sqlSession.insert("workRestMapper.insertStateBy", data);
		 int workNo=0;
		 Work work=null;
		 if(result !=0) { workNo=sqlSession.selectOne("workRestMapper.selectWorkNo"); }
		 System.out.println(workNo);
		 if(workNo !=0) { work=sqlSession.selectOne("workRestMapper.selectWork",workNo); }
		 System.out.println(work);
		 return work;
	}




	public List<Todo> todoTList(Map<String, Object> data) {
		return sqlSession.selectList("todoRestMapper.todoTList", data);
	}





	
}
