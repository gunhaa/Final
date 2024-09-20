package com.tlink.project.thread.model.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.common.utility.Util;
import com.tlink.project.thread.model.dao.ThreadDAO;
import com.tlink.project.thread.model.dto.ThreadChat;
import com.tlink.project.thread.model.dto.ThreadFile;
import com.tlink.project.thread.model.exception.FileUploadException;

@Service
public class ThreadServiceImpl implements ThreadService {

   @Autowired
   private ThreadDAO dao;

   @Transactional(rollbackFor = Exception.class)
   @Override
   public int insertChat(ThreadChat threadChat, List<MultipartFile> files, String webPath, String filePath) throws IllegalStateException, IOException {
      int chatNo = dao.insertChat(threadChat);
      
      if( chatNo > 0 ) {
         List<ThreadFile> uploadList = new ArrayList<>();
         
         for( int i = 0; i < files.size(); i++ ) {
            ThreadFile file = new ThreadFile();
            
            file.setChatNo(chatNo);
            file.setFilePath(filePath);
            file.setFileOriginName(files.get(i).getOriginalFilename());
            file.setFileRename(Util.fileRename(files.get(i).getOriginalFilename()));
            file.setFileCode(2);
            file.setTargetNumber(chatNo);
            
            uploadList.add(file);
         }
         
         if( !uploadList.isEmpty() ) {
            int result = dao.insertChatFile(uploadList);
            
            if( result == uploadList.size() ) {
               for( int i = 0; i < uploadList.size(); i++ ) {
                  String rename = uploadList.get(i).getFileRename();
                  
                  files.get(i).transferTo(new File(filePath + rename));
               }
            } else {
               throw new FileUploadException();
            }
         }
      }
      return chatNo;
   }

   

}
