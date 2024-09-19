package com.trink.project.thread;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.trink.project.member.dto.Member;
import com.trink.project.thread.model.dto.Chat;
import com.trink.project.thread.model.service.ChatService;

@RequestMapping("/chat")
@Controller
public class ChatController  {
	
	@Autowired
	private ChatService service;

	@GetMapping("/selectMember")
	public String selectMember(String query) {


		return null;
	}

	@PostMapping("/createThread")
	public String createThread() {
		return "chat/thread";
	}

	@PostMapping("/insert")
	public String insertThread(
			@RequestParam(value="chatType", required=false) String chatType,
			@RequestParam(value="message", required=false) String message,
			@RequestParam(value="files", required=false) List<MultipartFile> files,
			@SessionAttribute("loginMember") Member loginMember,
			HttpSession session) throws IOException {

		String webPath = "/resources/chatFile/"; 
		String filePath = session.getServletContext().getRealPath(webPath);

		Chat chat = new Chat();
		chat.setChatType(chatType);
		chat.setChatMessage(message);
		chat.setMemberNo(loginMember.getMemberNo());
		
		int result = service.insertChat(chat, files, webPath, filePath);
		if( result > 0 ) {
			
		} else {
			
		}
		
		

		return "redirect:";
	}
}
