package com.tlink.project.thread.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ThreadFile {

	private int chatNo;
	private String filePath;
	private String fileRename;
	private String fileOriginName;
	private int fileCode;
	private int targetNumber;
}
