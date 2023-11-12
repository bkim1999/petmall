package com.gdu.petmall.service;

import java.io.PrintWriter;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.petmall.dao.UserMapper;
import com.gdu.petmall.dto.InactiveUserDto;
import com.gdu.petmall.dto.UserDto;
import com.gdu.petmall.util.MyJavaMailUtils;
import com.gdu.petmall.util.MySecurityUtils;

import lombok.RequiredArgsConstructor;


@Transactional
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

	private final UserMapper userMapper;
	private final MySecurityUtils mySecurityUtils;
	 private final MyJavaMailUtils myJavaMailUtils;
	
	/*로그인*/
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


/*로그아웃*/
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





/*이메일 체크*/
@Transactional(readOnly=true)
@Override
public ResponseEntity<Map<String, Object>> checkEmail(String email) {
  
  Map<String, Object> map = Map.of("email", email);
  
  boolean enableEmail = userMapper.getUser(map) == null
                     && userMapper.getLeaveUser(map) == null
                     && userMapper.getInactiveUser(map) == null;
  
  return new ResponseEntity<>(Map.of("enableEmail", enableEmail), HttpStatus.OK);
  
}


/*인증코드 전송*/
@Override
public ResponseEntity<Map<String, Object>> sendCode(String email) {
  
  // RandomString 생성(6자리, 문자 사용, 숫자 사용)
  String code = mySecurityUtils.getRandomString(8, true, true);
  
  // 메일 전송
  myJavaMailUtils.sendJavaMail(email
                             , "petmall 인증 코드"
                             , "<div>인증코드는 <strong>" + code + "</strong>입니다.</div>");
  
  return new ResponseEntity<>(Map.of("code", code), HttpStatus.OK);
  
}




/*회원가입*/
@Override
public void join(HttpServletRequest request, HttpServletResponse response) {

  String email = request.getParameter("email");
  String pw = mySecurityUtils.getSHA256(request.getParameter("pw"));
  String name = mySecurityUtils.preventXSS(request.getParameter("name"));
  String gender = request.getParameter("gender");
  
  String[] arrMobile = request.getParameterValues("mobile");
  StringBuilder mobile =new StringBuilder();
  for(int i=0;i<arrMobile.length;i++){mobile.append(arrMobile[i]);}
  
  String postcode = request.getParameter("postcode");
  String roadAddress = request.getParameter("roadAddress");
  String jibunAddress = request.getParameter("jibunAddress");
  String detailAddress = mySecurityUtils.preventXSS(request.getParameter("detailAddress"));
  
  
  
 // 이벤트 수신 동의 체크 안돼있으면 null 전달됨. null 처리 해야함
  String event = request.getParameter("event");
  Optional<String> opt = Optional.ofNullable(event);
   event = opt.orElse("off"); 
  
  
  int adminAuthorState=Integer.parseInt(request.getParameter("admin_author_state"));
  
  
  UserDto user = UserDto.builder()
      .email(email)
      .pw(pw)
      .name(name)
      .gender(gender)
      .mobile(mobile.toString())
      .postcode(postcode)
      .roadAddress(roadAddress)
      .jibunAddress(jibunAddress)
      .detailAddress(detailAddress)
      .agree(event.equals("on") ? 1 : 0)
      .adminAuthorState(adminAuthorState)
      .build();
  
  
  int joinResult = userMapper.insertUser(user);
  
  

   try {
    
    response.setContentType("text/html; charset=UTF-8");
    PrintWriter out = response.getWriter();
    out.println("<script>");
    if(joinResult == 1) {
      request.getSession().setAttribute("user", userMapper.getUser(Map.of("email", email)));
      userMapper.insertAccess(email);
      out.println("alert('회원 가입되었습니다.')");
      out.println("location.href='" + request.getContextPath() + "/main.do'");
    } else {
      out.println("alert('회원 가입이 실패했습니다.')");
      out.println("history.go(-2)");
    }
    out.println("</script>");
    out.flush();
    out.close();
    
  } catch (Exception e) {
    e.printStackTrace();
  }
  
}








}
