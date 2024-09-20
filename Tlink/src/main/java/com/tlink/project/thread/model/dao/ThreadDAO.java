package com.tlink.project.thread.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.thread.model.dto.ThreadChat;
import com.tlink.project.thread.model.dto.ThreadFile;

@Repository
public class ThreadDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertChat(ThreadChat threadChat) {
		int result = sqlSession.insert("chatMapper.insertChat", threadChat);
		
		if( result > 0 ) result = threadChat.getChatNo();
		
		return result;
	}

	public int insertChatFile(List<ThreadFile> uploadList) {
		return sqlSession.insert("chatMapper.insertChatFile", uploadList);
	}
}
