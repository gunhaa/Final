package com.tlink.project.work.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tlink.project.user.model.dto.User;
import com.tlink.project.work.model.dto.Work;
import com.tlink.project.work.model.service.WorkRestService;
import com.tlink.project.work.model.service.WorkService;

@Controller
@RestController
public class WorkRest {
	
	@Autowired private WorkRestService service;
	@Autowired private WorkService workService;
	
	
	//작업수정
	@PutMapping(value=("/workSheet/detail"))
	public int update(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.update(data);
	}

	@DeleteMapping(value=("/workSheet/detail"))
	public int delete(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.delete(data);
	}
	
	
	
	
	

	
	//table
	@PostMapping(value=("/workList/table"))
	public int insertTable(@RequestBody Map<String, Object> data) {
		return service.insertTable(data);
	}
	
	
	@PostMapping(value=("/workList/table/pList"))              
	public List<Work> tablePList(@RequestBody Map<String, Object> data, Model model)          { 
		System.out.println(data);
		int projectNo=(int)data.get("projectNo");

		List<Work> pList=workService.tableParentList(projectNo);
		System.out.println(pList);
		return pList; 
	}
	
	
	
	//수정
	@PutMapping(value=("/workList/table/update/workTitle"))
	public int updateWorkTitle(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateWorkTitle(data);
	}
	@PutMapping(value=("/workList/table/update/dueDate"))
	public int updateDueDate(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateDueDate(data);
	}
	@PutMapping(value=("/workList/table/update/workState"))
	public int updateWorkState(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateWorkState(data);
	}
	@PutMapping(value=("/workList/table/update/workPriority"))
	public int updateWorkPriority(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateWorkPriority(data);
	}
	@PutMapping(value=("/workList/table/update/workManager"))
	public int updateWorkManager(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateWorkManager(data);
	}
	@PutMapping(value=("/workList/table/update/parentNo"))
	public int updateParentNo(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateParentNo(data);
	}
	
	
	
	
	//내작업
	@PostMapping(value=("/workList/mywork/insert"))
	public int insertMywork(@RequestBody Map<String, Object> data) {
		return service.insertMywork(data);
	}
	
	
	//상태별
	@PostMapping(value=("/workList/stateBy"))
	public Work insertStateBy(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.insertStateBy(data);
	}
	
	

}




