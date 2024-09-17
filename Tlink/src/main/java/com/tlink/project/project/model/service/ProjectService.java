package com.tlink.project.project.model.service;

import java.util.List;
import java.util.Map;

import com.tlink.project.project.model.dto.Project;

public interface ProjectService {

	List<Project> create(Project project);

	List<Project> autocomplete(Map<String, Object> map);
	

}
