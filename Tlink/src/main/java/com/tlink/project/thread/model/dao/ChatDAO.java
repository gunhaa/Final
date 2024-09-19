package com.trink.project.thread.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.trink.project.thread.model.dto.Chat;
import com.trink.project.thread.model.dto.ChatFile;

@Repository
public class ChatDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertChat(Chat chat) {
		int result = sqlSession.insert("chatMapper.insertChat", chat);
		
		if( result > 0 ) result = chat.getChatNo();
		
		return result;
	}

	public int insertChatFile(List<ChatFile> uploadList) {
		return sqlSession.insert("chatMapper.insertChatFile", uploadList);
	}
}
