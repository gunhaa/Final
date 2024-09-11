package com.tlink.project.chatting.model.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/video/*")
public class VideoController {
	

	@RequestMapping("*")
	public String myPageProject() {
		return "/videoConference/videoConference";
	}
	
}
