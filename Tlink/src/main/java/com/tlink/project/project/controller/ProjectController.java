package com.tlink.project.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProjectController {

	@RequestMapping("/project")
	public String project(int projectNo) {
		
		System.out.println(projectNo);
		
		return null;
	}
}
