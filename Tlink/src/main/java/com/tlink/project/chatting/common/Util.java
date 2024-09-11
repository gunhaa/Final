package com.tlink.project.chatting.common;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

public class Util {

	public static final void broadCasting(Map<String, WebSocketSession> projectMemberMap, String msg) {
		
		projectMemberMap.forEach((memberId, s)->{
			try {
				
				s.sendMessage(new TextMessage(msg));
				
			}catch(IOException e){
				e.printStackTrace();
			}
		});
		
	}
	
}
