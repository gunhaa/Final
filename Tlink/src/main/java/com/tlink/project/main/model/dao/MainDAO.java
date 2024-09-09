package com.tlink.project.main.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.user.model.dto.User;

@Repository
public class MainDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 로그인
	public User login(User inputUser) {
		
		return sqlSession.selectOne("userMapper.login", inputUser);
	}

	// 회원가입
	public int signUp(User inputUser) {
		
		return sqlSession.insert("userMapper.signUp", inputUser);
	}

}
