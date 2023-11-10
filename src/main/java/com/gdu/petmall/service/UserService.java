package com.gdu.petmall.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gdu.petmall.dto.UserDto;

public interface UserService {
	
  public void login(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public UserDto getUser(String email);
	public void logout(HttpServletRequest request,HttpServletResponse response);
}
