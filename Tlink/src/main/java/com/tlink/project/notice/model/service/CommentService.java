package com.tlink.project.notice.model.service;

import java.util.List;

import com.tlink.project.notice.model.dto.NoticeComment;

public interface CommentService {

	/**공지사항 게시글 댓글 조회
	 * @param noticeNo
	 * @return
	 */
	List<NoticeComment> selectCommentList(int noticeNo);

	/**공지사항 게시글 댓글 등록
	 * @param noticeComment
	 * @return
	 */
	int insert(NoticeComment noticeComment);

	/**공지사항 게시글 댓글 수정
	 * @param noticeComment
	 * @return
	 */
	int update(NoticeComment noticeComment);

	/** 공지사항 게시글 댓글 삭제
	 * @param commentNo
	 * @return
	 */
	int delete(int commentNo);

}
