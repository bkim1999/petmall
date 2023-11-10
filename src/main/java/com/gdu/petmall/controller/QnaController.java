package com.gdu.petmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.service.QnaService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/qna")
@RequiredArgsConstructor
@Controller
public class QnaController {

  private final QnaService qnaService;
	
  @GetMapping("/list.do")
  public String list() {
    return "qna/list";
  }
  
  @GetMapping("/write.form")
  public String write() {
	 return "qna/write";
  }
	  
  @PostMapping("/add.do")
  public String add(MultipartHttpServletRequest multipartRequest
		  		  , RedirectAttributes redirectAttributes) throws Exception{
	 boolean addResult = qnaService.addQna(multipartRequest);
	 redirectAttributes.addFlashAttribute("addResult", addResult);
	 return "redirect:/qna/list.do";
  }

}
