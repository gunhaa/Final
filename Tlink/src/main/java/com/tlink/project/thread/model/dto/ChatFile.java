package com.trink.project.thread.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatFile {

	private int chatNo;
	private String filePath;
	private String fileRename;
	private String fileOriginName;
	private int fileCode;
	private int targetNumber;
}
