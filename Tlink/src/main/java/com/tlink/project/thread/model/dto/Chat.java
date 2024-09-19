package com.tlink.project.thread.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Chat {
	private int chatNo;
	private int threadNo;
	private String chatMessage;
	private String chatType;
	private String chatCreateDate;
	private String chatUpdateDate;
	private int commentCount;

	private List<ChatFile> fileList;
	private List<ChatComment> commentList;
	
	private int memberNo;
	private String memberNickname;
	private String memberProfile;
	

}
