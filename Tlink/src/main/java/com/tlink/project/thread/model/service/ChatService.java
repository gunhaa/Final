package com.tlink.project.thread.model.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.thread.model.dto.Chat;

public interface ChatService {

	int insertChat(Chat chat, List<MultipartFile> files, String webPath, String filePath) throws IllegalStateException, IOException;
}
