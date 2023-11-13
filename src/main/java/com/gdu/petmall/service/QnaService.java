package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.petmall.dto.QnaDto;

public interface QnaService {
  public boolean addQna(MultipartHttpServletRequest multipartRequest) throws Exception;
  
  
  public int getLoggedInUserNo(HttpServletRequest request);
  public Map<String, Object> myPostList(HttpServletRequest request);
  
  public QnaDto getQna(int QnaNo);
  public int removeQna(int qnaNo);
  
  public int addReply(HttpServletRequest request, MultipartHttpServletRequest multipartRequest) ;
}


