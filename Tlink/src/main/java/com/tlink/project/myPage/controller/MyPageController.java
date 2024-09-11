package com.tlink.project.myPage.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.tlink.project.myPage.model.service.MyPageService;
import com.tlink.project.user.model.dto.User;

@Controller
@RequestMapping("/myPage/*")
public class MyPageController {
	
	@Autowired
	private MyPageService service;
	
	// 프로젝트 목록 페이지
	@GetMapping("/project")
	public String myPageProject(@SessionAttribute("loginUser") User user) {
		
		return "/myPage/myPage-project";
	}
	
	// 내 정보 페이지
	@GetMapping("/info")
	public String userInfo() {
		return "/myPage/myPage-info";
	}
	
	// 비밀번호 변경 페이지
	@GetMapping("/changePw")
	public String changePw() {
		return "/myPage/myPage-changePw";
	}
	
	// 회원 탈퇴 페이지
	@GetMapping("/secession")
	public String secession() {
		return "/myPage/myPage-secession";
	}
	
	// 비밀번호 변경
	@PostMapping("/changePw")
	@ResponseBody
	public int changePw(@RequestBody Map<String, String> map) {
		
		return service.changePw(map);
	}
	
	// 회원 탈퇴

}
