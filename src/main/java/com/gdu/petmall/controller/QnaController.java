package com.gdu.petmall.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.QnaDto;
import com.gdu.petmall.service.QnaService;

import lombok.RequiredArgsConstructor;

@RequestMapping
@RequiredArgsConstructor
@Controller
public class QnaController {

  private final QnaService qnaService;
	
  @GetMapping("/qna/list.do")
  public String list() {
    return "qna/list";
  }
  
  @GetMapping("/qna/write.form")
  public String write() {
	 return "qna/write";
  }
	  
  @PostMapping("/qna/add.do")
  public String add(MultipartHttpServletRequest multipartRequest
		  		  , RedirectAttributes redirectAttributes) throws Exception{
	 boolean addResult = qnaService.addQna(multipartRequest);
	 redirectAttributes.addFlashAttribute("addResult", addResult);
	 return "redirect:/qna/list.do";
  }
  
  
  @GetMapping("/user/myPostList")
  public String myPostList(HttpServletRequest request, Model model) {
      Map<String, Object> resultMap = qnaService.myPostList(request);
      model.addAttribute("myPostList", resultMap.get("myPostList"));
      return "user/myPostList";
  }
  
  @GetMapping("/user/qnadetail.do")
  public String detail(@RequestParam(value = "qnaNo", defaultValue = "0") int qnaNo, Model model) {
      QnaDto qna = qnaService.getQna(qnaNo); 
      model.addAttribute("qna", qna);
      return "user/qnadetail";
  }

  @PostMapping("/user/remove.do")
  public String remove(@RequestParam(value="qnaNo", required=false, defaultValue="0") int QnaNo
  					,   RedirectAttributes redirectAttributes) {
  	 int removeResult = qnaService.removeQna(QnaNo);
  	 redirectAttributes.addFlashAttribute("removeResult", removeResult);
  	 return "redirect:/user/myPostList";
  }
  
  @PostMapping("/user/qnadetail/addReply.do")
  public String addReply(HttpServletRequest request, RedirectAttributes redirectAttributes, MultipartHttpServletRequest multipartRequest) {
	  int addReplyResult = qnaService.addReply(request, multipartRequest);
	  redirectAttributes.addFlashAttribute("addReplyResult", addReplyResult);
	  return "redirect:/user/myPostList";
  }
  
  
  @ResponseBody
  @GetMapping(value="/user/qnadetail/commentList.do", produces="application/json")
  public Map<String, Object> commentList(HttpServletRequest request){
    return qnaService.loadCommentList(request);
  }
  

  
}