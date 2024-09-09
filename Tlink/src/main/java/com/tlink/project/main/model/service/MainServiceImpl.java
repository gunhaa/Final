package com.tlink.project.main.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.tlink.project.main.model.dao.MainDAO;
import com.tlink.project.user.model.dto.User;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainDAO dao;

	@Autowired // bean으로 등록된 객체 중 타입이 일치하는 Bean을 DI private BCryptPasswordEncoder
	private BCryptPasswordEncoder bcrypt;
	 

	// 로그인
	@Override
	public User login(User inputUser) {

		User loginUser = dao.login(inputUser);

		if (loginUser != null) {

			if (bcrypt.matches(inputUser.getUserPw(), loginUser.getUserPw())) {

				loginUser.setUserPw(null);

			} else {

				loginUser = null;
			}
		}

		return loginUser;
	}

	// 회원가입
	@Override
	public int signUp(User inputUser) {
		// 비밀번호를 Bcrypt를 이용하여 암호화 한 후 다시 inputMember에 세팅
		inputUser.setUserPw(bcrypt.encode(inputUser.getUserPw()));

		return dao.signUp(inputUser);
	}

}
