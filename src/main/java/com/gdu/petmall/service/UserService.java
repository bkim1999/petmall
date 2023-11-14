package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;

import com.gdu.petmall.dto.UserDto;

public interface UserService {
	
  public void login(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public UserDto getUser(String email);
	public void logout(HttpServletRequest request,HttpServletResponse response);
  public ResponseEntity<Map<String, Object>> checkEmail(String email);
  public ResponseEntity<Map<String, Object>> sendCode(String email);
  public void join(HttpServletRequest request, HttpServletResponse response);
}
