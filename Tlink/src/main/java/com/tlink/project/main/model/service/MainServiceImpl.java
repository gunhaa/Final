package com.tlink.project.main.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tlink.project.main.model.dao.MainDAO;
import com.tlink.project.user.model.dto.User;

import lombok.extern.slf4j.Slf4j;

@Service
public class MainServiceImpl implements MainService{

	@Autowired
	private MainDAO dao;
	
	@Override
	public User login(User user) {
		return dao.login(user);
	}

}
