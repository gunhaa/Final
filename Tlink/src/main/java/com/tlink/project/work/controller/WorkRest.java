package com.tlink.project.work.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.tlink.project.work.model.service.WorkRestService;

@Controller
@RestController
public class WorkRest {
	
	@Autowired private WorkRestService service;
	
	
	//작업수정
	@PutMapping(value=("/workSheet/detail"))
	public int update(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.update(data);
	}
	

	//작업수정
	@DeleteMapping(value=("/workSheet/detail"))
	public int delete(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.delete(data);
	}

}




