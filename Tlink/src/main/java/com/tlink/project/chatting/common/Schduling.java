package com.tlink.project.chatting.common;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ScheduledFuture;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

import com.tlink.project.chatting.websocket.VideoConference;

@Component
public class Schduling {

	private Logger logger = LoggerFactory.getLogger(VideoConference.class);
	
    private final TaskScheduler taskScheduler;

    public Schduling(TaskScheduler taskScheduler) {
        this.taskScheduler = taskScheduler;
    }

    public ScheduledFuture<?> scheduleMessage(String msg, LocalDateTime scheduledTime, Map<String, WebSocketSession> projectMemberMap) {
        
    	
    	long delay = Duration.between(LocalDateTime.now(), scheduledTime).toMillis();

        logger.info("예약 메시지 전송 딜레이 : {} ", delay);
        
        return taskScheduler.schedule(() -> {
            // 메시지 전송 로직
            Util.broadCasting(projectMemberMap, msg);
            
        }, new Date(System.currentTimeMillis() + delay));
    }
	
}
