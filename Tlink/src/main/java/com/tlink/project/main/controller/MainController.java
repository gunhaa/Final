package com.tlink.project.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tlink.project.main.model.service.MainService;
import com.tlink.project.user.model.dto.User;


@Controller
public class MainController {
	
	@Autowired
	private MainService service;

	// 메인 화면
	@RequestMapping("/")
	public String main() {
		return "/main/main";
	}
	
	// 로그인 화면
	@GetMapping("/login")
	public String login() {
		return "/main/login";
	}
	
	// 회원가입 화면
	@GetMapping("/signup")
	public String signup() {
		return "/myPage/signup";
	}
	
	// 비밀번호 찾기
	@GetMapping("/findPw")
	public String fingPw() {
		return "/myPage/findPw";
	}
	
	// 로그인
	@PostMapping("/login")
	public String login(User user, Model model) {
		
		// User loginUser = service.login(user);
		
		return null;
	}
	
	
	
	
}
