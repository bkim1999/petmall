package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.petmall.dto.InquiryDto;

public interface InquiryService {
  public boolean addInquiry(MultipartHttpServletRequest multipartRequest) throws Exception;
  public Map<String, Object> addIattach(MultipartHttpServletRequest multipartRequest) throws Exception;
  public Map<String, Object> getInquiryList(HttpServletRequest request);
  public void loadInquiry(HttpServletRequest request, Model model);
  public ResponseEntity<Resource> download(HttpServletRequest request);
  public ResponseEntity<Resource> downloadAll(HttpServletRequest request);
  public InquiryDto getInquiry(int inquiryNo);
  public int modifyInquiry(InquiryDto inquiry);
  public int removeInquiry(int inquiryNo);
  public Map<String, Object> removeIattach(HttpServletRequest request);

}
