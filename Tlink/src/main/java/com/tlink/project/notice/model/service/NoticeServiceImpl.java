package com.tlink.project.notice.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tlink.project.notice.model.dao.NoticeDAO;
import com.tlink.project.notice.model.dto.Notice;
import com.tlink.project.notice.model.dto.NoticePagination;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDAO dao;
	
	// 공지사항 조회하기
	@Override
	public Map<String, Object> selectAll(int cp) {
		int listCount = dao.getListCount();
		
		NoticePagination pagination = new NoticePagination(cp, listCount);
		
		List<Notice> noticeList = dao.selectAll(pagination);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeList", noticeList);
		map.put("pagination", pagination);
		
		
		return map;
	}
	
	
	// 공지사항 상단 고정글 조회하기
	@Override
	public List<Notice> selectTopNotice() {
		return dao.selectTopNotice();
	}

	// 공지사항 게시글 검색으로 조회하기
	@Override
	public Map<String, Object> selectNoticeList(Map<String, Object> paramMap, int cp) {
		
		int listCount = dao.selectNoticeList(paramMap);
		
		NoticePagination pagination = new NoticePagination(cp, listCount);
		
		List<Notice> noticeList = dao.selectNoticeList(paramMap, pagination);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("pagination", pagination);
		map.put("noticeList", noticeList);

		
		return map;
	}

	// 공지사항 상세 조회
	@Override
	public Notice selectNotice(Map<String, Object> map) {
		return dao.selectNotice(map);
	}

	// 조회수 증가
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateReadCount(int noticeNo) {
		return dao.updateReadCount(noticeNo);
	}

	// 공지사항 최근 20개의 게시글 제목만 조회하기
	@Override
	public List<Notice> selectNoticeTitleList() {
		return dao.selectNoticeTitleList();
	}
	
	
	
}
