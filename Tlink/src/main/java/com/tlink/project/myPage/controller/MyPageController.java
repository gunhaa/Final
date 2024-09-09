package com.tlink.project.myPage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/myPage/*")
public class MyPageController {
	
	// 프로젝트 목록
	@RequestMapping("/project")
	public String myPageProject() {
		return "/myPage/myPage-project";
	}
	
	// 내 정보
	@RequestMapping("/info")
	public String userInfo() {
		return "/myPage/myPage-info";
	}
	
	// 비밀번호 변경
	@RequestMapping("/changePw")
	public String changePw() {
		return "/myPage/myPage-changePw";
	}
	
	// 회원 탈퇴
	@RequestMapping("/secession")
	public String secession() {
		return "/myPage/myPage-secession";
	}

}
