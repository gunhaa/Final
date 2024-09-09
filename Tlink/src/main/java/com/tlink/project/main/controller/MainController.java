package com.tlink.project.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.tlink.project.main.model.service.MainService;
import com.tlink.project.user.model.dto.User;


@Controller
@SessionAttributes("loginUser")
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
	public String login(User inputUser, Model model) {
		
		User loginUser = service.login(inputUser);
		
		String path = "redirect:";
		
		if(loginUser != null) {
			model.addAttribute("loginUser", loginUser);
			path += "/myPage/project";
		}else {
			path += "/";
		}
		
		return path;
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		
		status.setComplete();
		
		return "redirect:/";
	}
	
	// 회원가입 진행
	@PostMapping("/signUp")
	public String signUp(User inputUser, String[] userAddr) {
		// ------------------ 매개변수 설명 -----------------------
		

		
		// 만약 주소를 입력하지 않은 경우(,,) null로 변경
		 if(inputUser.getUserAddr().equals(",,")) {
			 inputUser.setUserAddr(null);
		 }else {
			 // Stirng.join("구분자", String[])
			 // 배열의 요소를 하나의 문자열로 변경
			 // 단, 요소 사이에 "구분자" 추가
			String addr = String.join("^^^", userAddr);
			inputUser.setUserAddr(addr);
		 }
		
		// 회원가입 서비스 호출
		int result = service.signUp(inputUser);
		
		// 가입 성공 여부에 따라서 주소 결정
		String path = "redirect:";
		
		if(result > 0) { // 가입 성공
			// 메인 페이지
			// 000님의 가입을 환영합니다.
			path += "/";
			
			
		}else { // 가입 실패
			// 회원가입 페이지
			// 회원가입 실패
			// path += "/member/signUp"; // 절대 경로
			path += "signUp"; // 상대 경로
		}
		
		
		return path;
	}
	
	
	
	
}
