package com.tlink.project.thread.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.thread.model.dto.ThreadChat;
import com.tlink.project.thread.model.dto.ThreadFile;
import com.tlink.project.thread.model.dto.ThreadInfo;

@Repository
public class ThreadDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertChat(ThreadChat threadChat) {
		int result = sqlSession.insert("threadMapper.insertChat", threadChat);
		
		if( result > 0 ) result = threadChat.getChatNo();
		
		return result;
	}

	public int insertChatFile(List<ThreadFile> uploadList) {
		return sqlSession.insert("threadMapper.insertChatFile", uploadList);
	}

	public List<ThreadInfo> selectThread(int projectNo, int userNo) {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("projectNo", projectNo);
		map.put("userNo", userNo);
		
		return sqlSession.selectList("threadMapper.selectThread", map);
	}
}
