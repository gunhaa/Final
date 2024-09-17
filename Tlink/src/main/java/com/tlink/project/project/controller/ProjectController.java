package com.tlink.project.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tlink.project.project.model.dto.Project;
import com.tlink.project.project.model.service.ProjectService;
import com.tlink.project.user.model.dto.User;

@Controller
@RequestMapping("/project")
@SessionAttributes("loginUser")
public class ProjectController {
	
	@Autowired
	private ProjectService service;

	@PostMapping("/create")
	public String create(Project project, @SessionAttribute("loginUser") User loginUser,
			RedirectAttributes ra, Model model) {
		
		project.setManager(loginUser.getUserNo());
		
		System.out.println(project);
		
		List<Project> projectList = service.create(project);
		
		loginUser.setProjectList(projectList);
		
		ra.addFlashAttribute("message", project.getProjectTitle() + "이(가) 생성되었습니다.");
		
		model.addAttribute("loginUser", loginUser);
		
		return "redirect:/myPage/project";
	}
	
	// 자동완성
	@GetMapping("/autocomplete")
	@ResponseBody
	public List<Project> autocomplete(String query, @SessionAttribute("loginUser") User loginUser){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("query", query);
		map.put("userNo", loginUser.getUserNo());
		
		return service.autocomplete(map);
	}
	
	
}
