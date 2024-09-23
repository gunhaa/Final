package com.tlink.project.thread;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.thread.model.dto.ThreadChat;
import com.tlink.project.thread.model.dto.ThreadInfo;
import com.tlink.project.thread.model.service.ThreadService;
import com.tlink.project.user.model.dto.User;

@RequestMapping("/thread")
@Controller
public class ThreadController  {

	@Autowired
	private ThreadService service;

	/*
	 * @GetMapping("/thread") public String
	 * selectThread(@RequestParam(value="projectNo", required=false,
	 * defaultValue="1") int projectNo,
	 * 
	 * @SessionAttribute("loginUser") User loginUser, HttpSession session) {
	 * 
	 * List<ThreadInfo> threadInfo = service.selectThread(projectNo,
	 * loginUser.getUserNo());
	 * 
	 * String path = "";
	 * 
	 * if( threadInfo.isEmpty() ) { path = "thread/newThread"; } else {
	 * session.setAttribute("threadInfo", threadInfo);
	 * 
	 * path = "thread/thread"; }
	 * 
	 * return path; }
	 */
	
	@GetMapping("/thread")
	public String selectChat(@RequestParam(value="threadNo") int threadNo,
							 @SessionAttribute("loginUser") User loginUser,
							 Model model) {
		
		List<ThreadChat> chatList = service.selectChat(threadNo);
		
		model.addAttribute("chatList", chatList);
				
		return "thread/thread";
	}

	@GetMapping("/selectMember")
	@ResponseBody
	public List<Map<String, Object>> selectMember(int projectNo, String query, @SessionAttribute("loginUser") User loginUser) {
		
		List<Map<String, Object>> userList = service.selectUser(projectNo, loginUser.getUserNo(), query);

		return userList;
	}

	@PostMapping("/createThread")
	public String createThread(ThreadInfo threadInfo, Integer[] userList, int projectNo, 
							   @SessionAttribute("loginUser") User loginUser,
							   HttpSession session) {
		
		threadInfo.setUserList(Arrays.asList(userList));
		threadInfo.setProjectNo(projectNo);
				
		int result = service.insertThread(threadInfo);

		if( result > 0 ) {
			List<ThreadInfo> threadInfos = service.selectThread(projectNo, loginUser.getUserNo());
			System.out.println(threadInfos);
			
			session.setAttribute("threadInfo", threadInfos);
		}

		return "redirect:/thread/thread?projectNo=" + projectNo;
	}

	@PostMapping("/insert")
	public String insertThread(
			@RequestParam(value="chatType", required=false) String chatType,
			@RequestParam(value="message", required=false) String message,
			@RequestParam(value="threadNo") int threadNo,
			@RequestParam(value="files", required=false) List<MultipartFile> files,
			@SessionAttribute("loginUser") User loginUser,
			HttpSession session) throws IOException {

		String webPath = "/resources/chatFile/"; 
		String filePath = session.getServletContext().getRealPath(webPath);

		ThreadChat threadChat = new ThreadChat();
		threadChat.setChatType(chatType);
		threadChat.setChatMessage(message);
		threadChat.setMemberNo(loginUser.getUserNo());

		int result = service.insertChat(threadChat, files, webPath, filePath);
		if( result > 0 ) {
			// 여기서 스레드에 연결된 맴버들에게 메시지를 보낸다. 
			// List<User> userList = service.selectThreadUser(threadNo);
		} else {

		}

		return "redirect:";
	}
}
