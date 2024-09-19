package com.tlink.project.chatting.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.tlink.project.chatting.model.dto.Chat;
import com.tlink.project.chatting.model.dto.MyObjectType;
import com.tlink.project.chatting.model.dto.videoConference;
import com.tlink.project.chatting.model.service.VideoService;
import com.tlink.project.chatting.websocket.VideoConference;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/video/*")
public class VideoController {
	
	@Autowired
	private VideoService service;

	@Autowired
	private Map<String, String> whiteBoardMap;
	
	private Logger logger = LoggerFactory.getLogger(VideoController.class);
	
	
	@RequestMapping("test")
	public String myPageProject() {
		return "/videoConference/videoConference";
	}
	
	
	@PostMapping(value="/changeRoomName", produces="application/json; charset=UTF-8")
	@ResponseBody
	public int changeRoomName(@RequestBody videoConference data) {
		
		return service.changeRoomName(data);
	}
	
	@PostMapping(value="/selectTitle", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String selectTitle(@RequestBody videoConference data) {
		
		logger.info("projectNo : {}", data.getProjectNo());
		return service.selectTitle(data);
	}
	
	@PostMapping(value="/selectChat" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<Chat> selectChat(@RequestBody videoConference data) {
		return service.selectChat(data);
	}
	
	@PostMapping(value="/whatIsMyName" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public String whatIsMyName(@RequestBody MyObjectType data) {

		return service.whatIsMyName(data);
	}
	
	@PostMapping(value="/projectDrawStatus" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public String projectDrawStatus(@RequestBody MyObjectType data) {
		logger.info("=====================fetch 실행됨==================");
	
//		return whiteBoardMap.get(data.getProjectNo());
	    String result = whiteBoardMap.get(data.getProjectNo());
	    return result;
	}
	
	@PostMapping(value="/erase" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public String erase(@RequestBody MyObjectType data) {
		logger.info("=====================fetch 실행됨==================");
		whiteBoardMap.remove(data.getProjectNo());
		whiteBoardMap.put(data.getProjectNo(), "");
//		logger.info("map의 현재 data.getprojectNo의 value : {}" , whiteBoardMap.get(data.getProjectNo()));
	    String result = whiteBoardMap.get(data.getProjectNo());
	    return result;
	}
	
	
	
	
}
