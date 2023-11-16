package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.QnaDto;

public interface QnaService {
  public boolean addQna(MultipartHttpServletRequest multipartRequest) throws Exception;
  
  
  public int getLoggedInUserNo(HttpServletRequest request);
  public Map<String, Object> myPostList(HttpServletRequest request);
  
  public QnaDto getQna(int QnaNo);
  
  public int removeQna(int qnaNo);
  
  public int addReply(HttpServletRequest request,  RedirectAttributes redirectAttributes) ;
  
  public void loadQna(HttpServletRequest request, Model model);
  public ResponseEntity<Resource> download(HttpServletRequest request);
  
  public void loadCommentlist(HttpServletRequest request, Model model); 
}