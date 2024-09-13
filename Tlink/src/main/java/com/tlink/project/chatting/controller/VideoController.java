package com.tlink.project.chatting.controller;



import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tlink.project.chatting.model.dto.Chat;
import com.tlink.project.chatting.model.dto.videoConference;
import com.tlink.project.chatting.model.service.VideoService;
import com.tlink.project.chatting.websocket.VideoConference;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/video/*")
public class VideoController {
	
	@Autowired
	private VideoService service;

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
	
	
}
