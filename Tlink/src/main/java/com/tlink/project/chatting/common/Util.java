package com.tlink.project.chatting.common;

import java.io.IOException;
import java.text.SimpleDateFormat;
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
	
	// 파일명 변경 메소드
	public static String fileRename(String originFileName) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sdf.format(new java.util.Date(System.currentTimeMillis()));

		int ranNum = (int) (Math.random() * 100000); // 5자리 랜덤 숫자 생성

		String str = "_" + String.format("%05d", ranNum);

		String ext = originFileName.substring(originFileName.lastIndexOf("."));

		return date + str + ext;
	}
	
}
