package com.tlink.project.chatting.model.dto;

import org.springframework.web.socket.WebSocketSession;


import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Builder
public class Session {

	private String memberNo;
	private WebSocketSession session;
	
	public Session(String memberNo, WebSocketSession session) {
		this.memberNo = memberNo;
		this.session = session;
	}
}