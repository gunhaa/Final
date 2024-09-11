package com.tlink.project.myPage.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.tlink.project.myPage.model.dao.MyPageDAO;

@Service
public class MyPageServiceImpl implements MyPageService{

	@Autowired
	private MyPageDAO dao;
	
	@Autowired // bean으로 등록된 객체 중 타입이 일치하는 Bean을 DI
	private BCryptPasswordEncoder bcrypt;
	
	@Override
	public int changePw(Map<String, String> map) {
		
		String currentPw = dao.selectCurrentPw(map.get("userNo"));
		
		int result = 0;
		
		if(bcrypt.matches(map.get("currentPw"), currentPw)) { // 같은 경우
			
			map.put("newPw", bcrypt.encode(map.get("newPw")));
			
			result = dao.changePw(map);
			
		}
		
		
		return result; 
	}

}
