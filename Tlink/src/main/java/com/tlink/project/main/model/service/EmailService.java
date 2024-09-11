package com.tlink.project.main.model.service;

import java.util.Map;

public interface EmailService {

	int signUp(String email, String string);
	
	String createAuthKey();

	int checkAuthKey(Map<String, Object> paramMap);

}
