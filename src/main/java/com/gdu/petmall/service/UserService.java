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
	
	
	public ResponseEntity<Map<String, Object>> findId(HttpServletRequest request);
	public ResponseEntity<Map<String, Object>> findPw(HttpServletRequest request);
	public void getPoint(HttpServletRequest request, Model model);
	public UserDto getUser(String email);
  public ResponseEntity<Map<String, Object>> checkEmail(String email);
  public ResponseEntity<Map<String, Object>> sendCode(String email);
  
  
  /*네이버 api관련*/
  public void naverJoin(HttpServletRequest request, HttpServletResponse response);//네이버 간편가입
  public String getNaverLoginURL(HttpServletRequest request) throws Exception;// 네이버로그인 url 가져와
  public String getNaverLoginAccessToken(HttpServletRequest request) throws Exception; //인증토큰 가져와
  public UserDto getNaverProfile(String accessToken) throws Exception; // 네이버 로그인 후속작업
  public void naverLogin(HttpServletRequest request, HttpServletResponse response, UserDto naverProfile) throws Exception;//네이버로그인

  
}
