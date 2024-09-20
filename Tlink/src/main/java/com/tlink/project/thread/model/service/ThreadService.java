package com.tlink.project.thread.model.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.thread.model.dto.ThreadChat;

public interface ThreadService {

   int insertChat(ThreadChat threadChat, List<MultipartFile> files, String webPath, String filePath) throws IllegalStateException, IOException;
}
