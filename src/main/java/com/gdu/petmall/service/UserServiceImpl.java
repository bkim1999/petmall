package com.gdu.petmall.service;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.gdu.petmall.dao.UserMapper;
import com.gdu.petmall.dto.InactiveUserDto;
import com.gdu.petmall.dto.UserDto;
import com.gdu.petmall.util.MySecurityUtils;

import lombok.RequiredArgsConstructor;



@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

	private final UserMapper userMapper;
	private final MySecurityUtils mySecurityUtils;
	
	//로그인
@Override
public void login(HttpServletRequest request, HttpServletResponse response) throws Exception {
	 
  String email = request.getParameter("email");
  String pw = mySecurityUtils.getSHA256(request.getParameter("pw")); 
  
  Map<String, Object> map = Map.of("email", email
                                 , "pw", pw);
	
  
  HttpSession session = request.getSession();
  
  
  //휴면 회원인지 확인
  InactiveUserDto inactiveUser = userMapper.getInactiveUser(map);
  if(inactiveUser != null) {
    session.setAttribute("inactiveUser", inactiveUser);
    response.sendRedirect(request.getContextPath() + "/user/active.form"); // 계정 활성페이지로 보내
  }
  
  
  //로그인 하기
  UserDto user = userMapper.getUser(map);
  
  
  
  if(user != null) {				// 세션에 유저가 없으면
    request.getSession().setAttribute("user", user);
    userMapper.insertAccess(email);
    response.sendRedirect(request.getParameter("referer"));
  } else {
    response.setContentType("text/html; charset=UTF-8");
    PrintWriter out = response.getWriter();
    out.println("<script>");
    out.println("alert('일치하는 회원 정보가 없습니다.')");
    out.println("location.href='" + request.getContextPath() + "/main.do'");
    out.println("</script>");
    out.flush();
    out.close();
    
  }
}
	
	
	// 회원정보 가져와
@Override
public UserDto getUser(String email) {
  return userMapper.getUser(Map.of("email", email));
}


// 로그아웃
@Override
public void logout(HttpServletRequest request, HttpServletResponse response) {

HttpSession session=request.getSession();
session.invalidate();// 세션 초기화

try {
	response.sendRedirect(request.getContextPath()+"/main.do");
	
}catch (Exception e) {
e.printStackTrace();
}

}






}
