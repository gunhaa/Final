package com.tlink.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	// 메인 화면
	@RequestMapping("/")
	public String main() {
		return "/main/main";
	}
	
	// 로그인 화면
	@RequestMapping("/login")
	public String login() {
		return "/main/login";
	}
	
	// 회원가입 화면
	@RequestMapping("/signup")
	public String signup() {
		return "/myPage/signup";
	}
	
	// 비밀번호 찾기
	@RequestMapping("/findPw")
	public String fingPw() {
		return "/myPage/findPw";
	}
	

	
	
	
}
