package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.petmall.dto.InquiryDto;

public interface InquiryService {
  
  public boolean addInquiry(MultipartHttpServletRequest multipartRequest) throws Exception;

  public void getInquiryList(HttpServletRequest request, Model model);
  
  public void loadInquiry(HttpServletRequest request, Model model);
  
  public InquiryDto getInquiry(int inquiryNo);
  
  public Map<String, Object> getIattachList(HttpServletRequest request);
  
  public int modifyInquiry(InquiryDto inquiry);
  
  public int removeInquiry(int inquiryNo);
}
