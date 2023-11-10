package com.gdu.petmall.service;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface QnaService {
  public boolean addQna(MultipartHttpServletRequest multipartRequest) throws Exception;
}
