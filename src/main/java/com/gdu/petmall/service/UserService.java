package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.UserDto;

public interface UserService {
	
  public void login(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public void logout(HttpServletRequest request,HttpServletResponse response);
	public void join(HttpServletRequest request, HttpServletResponse response);
	public void leave(HttpServletRequest request, HttpServletResponse response);
	public ResponseEntity<Map<String, Object>> modify(HttpServletRequest request);	
	
	
	public void getPoint(HttpServletRequest request, Model model);
	public UserDto getUser(String email);
  public ResponseEntity<Map<String, Object>> checkEmail(String email);
  public ResponseEntity<Map<String, Object>> sendCode(String email);
  

  
}
