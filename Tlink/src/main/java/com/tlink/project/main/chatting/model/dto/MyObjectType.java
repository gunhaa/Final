package com.tlink.project.main.chatting.model.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MyObjectType {

	private String type;
	private String memberNo;
	private Map<String, Object> body;
	private String targetNo;
	private String makeAnswerMemberNo;
	private String setAnswerMemberNo;
	private String iceSender;
	private String chatContent;
	private String key;
}
