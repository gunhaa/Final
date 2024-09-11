package com.tlink.project.myPage.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MyPageDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 현재 비밀번호 가져오기
	public String selectCurrentPw(String userNo) {
		return sqlSession.selectOne("myPageMapper.selectCurrentPw", userNo);
	}
	
	public int changePw(Map<String, String> map) {
		return sqlSession.update("myPageMapper.changePw", map);
	}


}
