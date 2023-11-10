package com.gdu.petmall.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.petmall.service.UserService;

import lombok.RequiredArgsConstructor;




@RequestMapping(value="/user")
@RequiredArgsConstructor
@Controller
public class UserController {

	
	private final UserService userService;

	
	//로그인 폼
	@GetMapping(value = "/login.form")
	public String loginForm(HttpServletRequest request, Model model) throws Exception{
    String referer = request.getHeader("referer");
    model.addAttribute("referer", referer == null ? request.getContextPath() + "/main.do" : referer);
    
    //네이버 간편 로그인
		return"user/login";
	}
	
	
 // 회원가입 방식 선택 폼
	@GetMapping(value = "/join_option.form")
	public String joinOption() {
		
		return"user/join_option";
	}
	
 //일반 회원가입폼
	@GetMapping("/join.form")
	public String joinForm() {
		return "user/join";
	}
	
	
	//마이페이지로 이동
	@GetMapping(value = "/mypage")
	public String myPage() {
		
		return"user/mypage";
	}
	
	
	//일반 로그인 
	@PostMapping(value = "/login.do")
		public void login(HttpServletRequest request, HttpServletResponse response)throws Exception {
			 userService.login(request, response);
		}
	
	
	//로그아웃
	@GetMapping("/logout.do")
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		userService.logout(request,response);
	}
	
	
}