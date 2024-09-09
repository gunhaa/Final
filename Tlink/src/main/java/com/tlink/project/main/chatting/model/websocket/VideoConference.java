package com.tlink.project.main.chatting.model.websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tlink.project.main.chatting.model.dto.MyObjectType;
import com.tlink.project.main.chatting.model.dto.Session;

public class VideoConference extends TextWebSocketHandler {

	private static final String MSG_TYPE_OFFER = "offer";
	private static final String MSG_TYPE_ANSWER = "answer";
	private static final String MSG_TYPE_ICECANDIDATE = "icecandidate";
	private static final String MSG_TYPE_PROJECTNO = "projectNo";
	private static final String MSG_TYPE_MEMBERNO = "memberNo";
	private static final String MSG_TYPE_needMemberKey = "needMemberKey";
	private static final String MSG_TYPE_addSession = "addSession";
	private static final String MSG_TYPE_EXIT = "exit";
	private static final String MSG_TYPE_NULL = "null";

	private Logger logger = LoggerFactory.getLogger(VideoConference.class);

	private final Object offerLock = new Object();
	private final Object answerLock = new Object();
	private final Object iceCandidateLock = new Object();
	private final Object memberNoLock = new Object();
	private final Object needMemberKeyLock = new Object();

	private Map<String, WebSocketSession> sessions = new ConcurrentHashMap<String, WebSocketSession>();

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
//		logger.info("obj의 body : " +  obj.getBody());

		if (obj.getType().equals(MSG_TYPE_addSession)) {

			sessions.put(obj.getMemberNo(), session);

			logger.info("새로운 세션 추가됨");
		}

		if (obj.getType().equals(MSG_TYPE_needMemberKey)) {
			logger.info("NEEDMEMBERKEY 실행");

			Map<String, Object> msg = new HashMap<>();
			msg.put("type", "needMemberKey");

			String jsonMsg = objectMapper.writeValueAsString(msg);

			sessions.forEach((memberId, s) -> {
				try {
					s.sendMessage(new TextMessage(jsonMsg));
				} catch (IOException e) {
					e.printStackTrace();
				}
			});

		}

		if (obj.getType().equals(MSG_TYPE_MEMBERNO)) {
			logger.info("MEMBERNO 실행");

			Map<String, Object> msg = new HashMap<>();
			msg.put("type", "otherMemberNo");
			msg.put("memberNo", obj.getMemberNo());

			String jsonMsg = objectMapper.writeValueAsString(msg);

			sessions.forEach((memberId, s) -> {
				try {
					s.sendMessage(new TextMessage(jsonMsg));
				} catch (IOException e) {
					e.printStackTrace();
				}
			});

		}

		if (obj.getType().equals(MSG_TYPE_OFFER)) {
			logger.info("OFFER 실행");

			Map<String, Object> msg = new HashMap<>();

			msg.put("type", MSG_TYPE_OFFER);
			msg.put("sdp", obj.getBody().get("sdp"));
			msg.put("makeAnswerMemberNo", obj.getMakeAnswerMemberNo());

			String jsonMsg = objectMapper.writeValueAsString(msg);
			logger.info("offer가 보낸 targetNo : " + obj.getTargetNo());
			WebSocketSession ses = sessions.get(obj.getTargetNo());
			ses.sendMessage(new TextMessage(jsonMsg));

//			logger.info("obj의 sdp찾기에 성공해서 보여줄거임 : " + obj.getBody().get("sdp"));
		}

		if (obj.getType().equals(MSG_TYPE_ANSWER)) {
			logger.info("ANSWER 실행");

			Map<String, Object> msg = new HashMap<>();

			msg.put("type", MSG_TYPE_ANSWER);
			msg.put("sdp", obj.getBody().get("sdp"));
			msg.put("setAnswerMemberNo", obj.getSetAnswerMemberNo());

			String jsonMsg = objectMapper.writeValueAsString(msg);
			logger.info("answer가 보낸 targetNo : " + obj.getTargetNo());
			WebSocketSession ses = sessions.get(obj.getTargetNo());
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
			logger.info("answer가 보낸 targetNo : {}" + obj.getTargetNo());

			WebSocketSession ses = sessions.get(obj.getTargetNo());
			ses.sendMessage(new TextMessage(jsonMsg));

		}

	}

	// afterConnectionClosed - 클라이언트와 연결이 종료되면 실행된다.
	@Override
	public synchronized void afterConnectionClosed(final WebSocketSession session, final CloseStatus status) throws Exception {

		logger.info("웹소켓 연결 끊김, 코드: {}, 이유: {}", status.getCode(), status.getReason());

		String exitMemberNo = "";

		if(sessions.containsValue(session)) {
			for(Entry<String, WebSocketSession> s : sessions.entrySet()) {
				
				if(s.getValue()==session) {
					exitMemberNo = s.getKey();
				}
				
			}
		}
		sessions.remove(exitMemberNo);

		Map<String, Object> msg = new HashMap<>();

		msg.put("type", MSG_TYPE_EXIT);
		msg.put("exitMemberNo", exitMemberNo);

		ObjectMapper objectMapper = new ObjectMapper();
		String jsonMsg = objectMapper.writeValueAsString(msg);
		sessions.forEach((memberId, s) -> {
			try {
				s.sendMessage(new TextMessage(jsonMsg));
				logger.info("삭제 요청 메시지 보낸 상대 : {} " + memberId);
			} catch (IOException e) {
				e.printStackTrace();
			}
		});

	}

}
