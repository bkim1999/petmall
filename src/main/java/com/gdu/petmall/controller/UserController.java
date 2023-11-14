package com.gdu.petmall.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.UserDto;
import com.gdu.petmall.service.UserService;

import lombok.RequiredArgsConstructor;


@RequestMapping(value="/user")
@RequiredArgsConstructor
@Controller
public class UserController {

	
	private final UserService userService;

	
	//로그인 폼으로 이동
	@GetMapping(value = "/login.form")
	public String loginForm(HttpServletRequest request, Model model) throws Exception{
    String referer = request.getHeader("referer");
    model.addAttribute("referer", referer == null ? request.getContextPath() + "/main.do" : referer);
    
    //네이버 간편 로그인
		return"user/login";
	}
	
	
 // 회원가입 방식 선택 폼으로 이동
	@GetMapping(value = "/join_option.form")
	public String joinOption() {
		
		return"user/join_option";
	}
	
 //회원가입폼 으로 이동
	@GetMapping("/join.form")
	public String joinForm() {
		return "user/join";
	}
	
	
	//마이페이지로 이동
	@GetMapping(value = "/mypage")
	public String myPage() {
		
		return"user/mypage";
	}
	
	//회원정보 수정폼으로 이동
  @GetMapping("/mypage/profile.form")
  public String mypageForm() {
    return "user/profile";
  }
  
  
  //포인트 확인 페이지로 이동
  @PostMapping(value ={"/point","/mypage/point"})
	public String myPoint(HttpServletRequest request,Model model ) { 
  	userService.getPoint(request,model); 
  	int userNo=Integer.parseInt(request.getParameter("userNo"));
  	return "user/point";
  }
	
	
	
	// 로그인 
	@PostMapping(value = "/login.do")
		public void login(HttpServletRequest request, HttpServletResponse response)throws Exception {
			 userService.login(request, response);
		}
	
	
	//로그아웃
	@GetMapping("/logout.do")
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		userService.logout(request,response);
	}
	
	//회원가입
  @PostMapping("/join.do")
  public void join(HttpServletRequest request, HttpServletResponse response) {
    userService.join(request, response);
  }
	
  
  //회원탈퇴
  @PostMapping("/mypage/leave.do")
  public void leave(HttpServletRequest request, HttpServletResponse response) {
    userService.leave(request, response);
  }
  
  
 //이메일 체크
  @GetMapping(value="/checkEmail.do", produces=MediaType.APPLICATION_JSON_VALUE)
  public ResponseEntity<Map<String, Object>> checkEmail(@RequestParam String email) {
    return userService.checkEmail(email);
  }
  
  //코드 전송
  @GetMapping(value="/sendCode.do", produces=MediaType.APPLICATION_JSON_VALUE)
  public ResponseEntity<Map<String, Object>> sendCode(@RequestParam String email) {
    return userService.sendCode(email);
  }
  
  //회원정보 수정
  @PostMapping(value="/mypage/modify.do", produces=MediaType.APPLICATION_JSON_VALUE)
  public ResponseEntity<Map<String, Object>> modify(HttpServletRequest request) {
    return userService.modify(request);
  }
  
  
  //포인트 증감차감 테스트(추후에 삭제해야함) 
  @PostMapping(value = "/point.do")
  public void pointTest(HttpServletRequest request) {
 
  }
  
  
	
}
