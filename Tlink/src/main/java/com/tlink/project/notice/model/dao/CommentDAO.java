package com.tlink.project.notice.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.notice.model.dto.NoticeComment;

@Repository
public class CommentDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<NoticeComment> selectCommentList(int noticeNo) {
		return sqlSession.selectList("noticeMapper.selectCommentList", noticeNo);
	}

	public int insert(NoticeComment noticeComment) {
		return sqlSession.insert("noticeCommentMapper.insert", noticeComment);
	}

	public int update(NoticeComment noticeComment) {
		return sqlSession.update("noticeCommentMapper.update", noticeComment);
	}

	public int delete(int commentNo) {
		return sqlSession.delete("noticeCommentMapper.delete", commentNo);
	}


	
	
	
}
