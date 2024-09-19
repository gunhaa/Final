package com.tlink.project.notice.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeComment {
	
	private int commentNo;
    private String commentContent;
    private String commentCreateDate;
    private int noticeNo;
    private int memberNo;
    private String commentDeleteFlag;
    private int parentNo;
    private String memberNickname;
    private String profileImage;

}
