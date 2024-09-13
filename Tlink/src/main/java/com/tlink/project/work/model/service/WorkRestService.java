package com.tlink.project.work.model.service;

import java.util.Map;

import org.springframework.stereotype.Service;


public interface WorkRestService {

	int update(Map<String, Object> data);

	int delete(Map<String, Object> data);



}
