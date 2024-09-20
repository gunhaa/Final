package com.tlink.project.thread;

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

import com.tlink.project.thread.model.dto.ThreadChat;
import com.tlink.project.thread.model.dto.ThreadInfo;
import com.tlink.project.thread.model.service.ThreadService;
import com.tlink.project.user.model.dto.User;

@RequestMapping("/thread")
@Controller
public class ThreadController  {
   
   @Autowired
   private ThreadService service;
   
   @GetMapping("/thread")
   public String selectThread(@RequestParam(value="projectNo", required=false, defaultValue="1") int projectNo,
		   					  @SessionAttribute("loginUser") User loginUser) {
      
	   List<ThreadInfo> list = service.selectThread(projectNo, loginUser.getUserNo());
	   
	   return "thread/thread";
   }

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
         
      } else {
         
      }
      
      

      return "redirect:";
   }
}
