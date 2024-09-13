package com.tlink.project.chatting.websocket;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tlink.project.chatting.common.Schduling;
import com.tlink.project.chatting.common.Util;
import com.tlink.project.chatting.model.dto.MyObjectType;
import com.tlink.project.chatting.model.service.VideoService;



public class VideoConference extends TextWebSocketHandler {

	private static final String MSG_TYPE_OFFER = "offer";
	private static final String MSG_TYPE_ANSWER = "answer";
	private static final String MSG_TYPE_ICECANDIDATE = "icecandidate";
	private static final String MSG_TYPE_CHAT = "chat";
	private static final String MSG_TYPE_MEMBERNO = "memberNo";
	private static final String MSG_TYPE_NEEDMEMBERKEY = "needMemberKey";
	private static final String MSG_TYPE_ADDSESSION = "addSession";
	private static final String MSG_TYPE_BOOKED = "booked";
	private static final String MSG_TYPE_EXIT = "exit";

	private Logger logger = LoggerFactory.getLogger(VideoConference.class);

	@Autowired
    private Schduling schduling;
	
	@Autowired
	private VideoService service;
	
	// 프로젝트번호 저장용 map
	private Map<String, Map<String, WebSocketSession>> projectMap = new ConcurrentHashMap<String, Map<String,WebSocketSession>>();
	

	@Override
	public void afterConnectionEstablished(final WebSocketSession session) throws Exception {

		logger.info("{}연결됨", session.getId());

	}

	// handlerTextMessage - 클라이언트로부터 텍스트 메세지를 받았을때 실행
	@Override
	protected synchronized void handleTextMessage(final WebSocketSession session, final TextMessage message)
			throws Exception {

		// 전달받은 내용은 JSON 형태의 String
		logger.info("전달받은 내용 : " + message.getPayload());

		ObjectMapper objectMapper = new ObjectMapper();

		MyObjectType obj = objectMapper.readValue(message.getPayload(), MyObjectType.class);
		
		
		if (obj.getType().equals(MSG_TYPE_ADDSESSION)) {

			
	        Map<String, WebSocketSession> projectSessions = projectMap.get(obj.getProjectNo());
	        if (projectSessions == null) {
	            projectSessions = new ConcurrentHashMap<>();
	            
	            projectMap.put(obj.getProjectNo(), projectSessions);
	        }
	        projectSessions.put(obj.getMemberNo(), session);
	        
            try {
            	// 방에 없다면 프로젝트 멤버로 삽입한다.
            	int res = service.makeRoom(obj.getProjectNo(), obj.getMemberNo());
            	logger.info("res : {}" , res);
            	
            } catch(Exception e) {
            	// 있다면, 프로젝트 멤버의 상태를 변경한다.
            	int res = service.changeStatusY(obj.getProjectNo(), obj.getMemberNo());
            	logger.info("changeY : {}" , res);
            }
            
			logger.info("새로운 세션 추가됨");
		}

		Map<String, WebSocketSession> project = projectMap.get(obj.getProjectNo());
		
		logger.info("obj.getType : {}" , obj.getType());
		
		logger.info("obj.getProjectNo : {}" , obj.getProjectNo());
		
		if (obj.getType().equals(MSG_TYPE_NEEDMEMBERKEY)) {
			logger.info("NEEDMEMBERKEY 실행");

			Map<String, Object> msg = new HashMap<>();
			msg.put("type", "needMemberKey");

			String jsonMsg = objectMapper.writeValueAsString(msg);

			
			Util.broadCasting(project,jsonMsg);
			
		}

		if (obj.getType().equals(MSG_TYPE_MEMBERNO)) {
			logger.info("MEMBERNO 실행");

			Map<String, Object> msg = new HashMap<>();
			msg.put("type", "otherMemberNo");
			msg.put("memberNo", obj.getMemberNo());

			String jsonMsg = objectMapper.writeValueAsString(msg);

			Util.broadCasting(project,jsonMsg);
			

		}

		if (obj.getType().equals(MSG_TYPE_OFFER)) {
			logger.info("OFFER 실행");

			Map<String, Object> msg = new HashMap<>();

			msg.put("type", MSG_TYPE_OFFER);
			msg.put("sdp", obj.getBody().get("sdp"));
			msg.put("makeAnswerMemberNo", obj.getMakeAnswerMemberNo());

			String jsonMsg = objectMapper.writeValueAsString(msg);
			logger.info("offer가 보낸 targetNo : {}" , obj.getTargetNo());
			WebSocketSession ses = project.get(obj.getTargetNo());
			ses.sendMessage(new TextMessage(jsonMsg));


		}

		if (obj.getType().equals(MSG_TYPE_ANSWER)) {
			logger.info("ANSWER 실행");

			Map<String, Object> msg = new HashMap<>();

			msg.put("type", MSG_TYPE_ANSWER);
			msg.put("sdp", obj.getBody().get("sdp"));
			msg.put("setAnswerMemberNo", obj.getSetAnswerMemberNo());

			String jsonMsg = objectMapper.writeValueAsString(msg);
			logger.info("answer가 보낸 targetNo : {} " , obj.getTargetNo());
			WebSocketSession ses = project.get(obj.getTargetNo());
			ses.sendMessage(new TextMessage(jsonMsg));

		}

		if (obj.getType().equals(MSG_TYPE_ICECANDIDATE)) {
			logger.info("ICECANDIDATE 실행");

			Map<String, Object> msg = new HashMap<>();

			msg.put("type", MSG_TYPE_ICECANDIDATE);
			msg.put("candidate", obj.getBody().get("candidate"));
			msg.put("sdpMLineIndex", obj.getBody().get("sdpMLineIndex"));
			msg.put("sdpMid", obj.getBody().get("sdpMid"));
			msg.put("iceSender", obj.getIceSender());

			String jsonMsg = objectMapper.writeValueAsString(msg);
			logger.info("icecandidate가 보낸 targetNo : {}" , obj.getTargetNo());

			WebSocketSession ses = project.get(obj.getTargetNo());
			ses.sendMessage(new TextMessage(jsonMsg));

		}

		if (obj.getType().equals(MSG_TYPE_BOOKED)) {
			logger.info("BOOKED 실행");
			
	        String dateTimeString = obj.getBookedTime();
	        
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
	        
	        LocalDateTime localDateTime = LocalDateTime.parse(dateTimeString, formatter);
	        
			Map<String, Object> msg = new HashMap<>();

			msg.put("type", MSG_TYPE_CHAT);
			msg.put("chatContent", obj.getBookedMsg());
			msg.put("memberNo", obj.getMemberNo());
	        
			String jsonMsg = objectMapper.writeValueAsString(msg);
			
			schduling.scheduleMessage(jsonMsg, localDateTime , project , obj.getProjectNo(), obj.getMemberNo(), obj.getBookedMsg());

			msg.put("projectNo", obj.getProjectNo());
			// db insert
			int res = service.insertBookedChat(msg);
			
			if(res>0) {
				logger.info("예약 메시지 db 삽입 완료");
			} else {
				logger.info("예약 메시지 db 삽입 실패");
			}
			
		}

		if (obj.getType().equals(MSG_TYPE_CHAT)) {
			logger.info("CHAT 실행");
			
			Map<String, Object> msg = new HashMap<>();

			msg.put("type", MSG_TYPE_CHAT);
			msg.put("chatContent", obj.getChatContent());
			msg.put("memberNo", obj.getMemberNo());

			String jsonMsg = objectMapper.writeValueAsString(msg);

			Util.broadCasting(project,jsonMsg);
			
			// db에도 삽입시킨다.
			msg.put("projectNo", obj.getProjectNo());
			int res = service.chatSend(msg);
			if(res>0) {
				logger.info("chat db저장 완료");
			} else {
				logger.info("chat db저장 실패");			
			}
			
		}

	}

	// afterConnectionClosed - 클라이언트와 연결이 종료되면 실행된다.
	@Override
	public synchronized void afterConnectionClosed(final WebSocketSession session, final CloseStatus status) throws Exception {

		logger.info("웹소켓 연결 끊김, 코드: {}, 이유: {}", status.getCode(), status.getReason());
		

	    String exitMemberNo = null;
	    String exitProjectNo = null;


	    for (Map.Entry<String, Map<String, WebSocketSession>> projectEntry : projectMap.entrySet()) {
	        Map<String, WebSocketSession> sessionMap = projectEntry.getValue();
	        String projectNo = projectEntry.getKey(); // 현재 프로젝트 번호

	        String memberNoToRemove = null;
	        for (Map.Entry<String, WebSocketSession> sessionEntry : sessionMap.entrySet()) {
	            if (sessionEntry.getValue().equals(session)) {
	                memberNoToRemove = sessionEntry.getKey(); // 해당 세션 ID를 찾음
	                exitMemberNo = sessionEntry.getKey(); // 나간 멤버의 번호
	                exitProjectNo = projectNo; // 나간 세션의 프로젝트 번호
	               
	            	int res = service.changeStatusN(exitProjectNo, exitMemberNo);
	            	logger.info("changeY : {}" , res);
	                
	                logger.info("나간 exitMemberNo : {}", exitMemberNo);
	                break; 
	            }
	        }

	        if (memberNoToRemove != null) {
	            sessionMap.remove(memberNoToRemove);

	            // 나간 프로젝트 번호 로그 출력
	            logger.info("나간 exitProjectNo : {}", exitProjectNo);

	            if (sessionMap.isEmpty()) {
	                projectMap.remove(projectNo);
	                exitProjectNo = ""; 
	                logger.info("프로젝트 {}에서 세션이 모두 제거되어 프로젝트 삭제됨", projectNo);
	            }
	            break; 
	        }
	    }

	    // 세션이 속한 프로젝트가 없을 때 처리
	    if (exitProjectNo == null) {
	        logger.info("세션이 속한 프로젝트가 없음");
	    }
	    

		
		
		
		Map<String, Object> msg = new HashMap<>();

		msg.put("type", MSG_TYPE_EXIT);
		msg.put("exitMemberNo", exitMemberNo);

		ObjectMapper objectMapper = new ObjectMapper();
		String jsonMsg = objectMapper.writeValueAsString(msg);

		final String lambdaExitProjectNo = exitProjectNo;
		
		projectMap.forEach((targetProjectNo, projectSessions) -> {

			if(targetProjectNo == lambdaExitProjectNo) {
				
				Util.broadCasting(projectSessions,jsonMsg);

				
			}
			
		});
		

	}

}
