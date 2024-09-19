package com.tlink.project.chatting.common;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MapConfig {

    @Bean
    public Map<String, String> whiteBoardMap() {
        return new ConcurrentHashMap<>();
    }
    
}

