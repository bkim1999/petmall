package com.gdu.petmall.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.petmall.dto.EventDto;

public interface EventService {
  
  public void loadEventList(HttpServletRequest request, Model model);
  public EventDto loaddetailEventList(int eventNo);
  public int increaseHit(int eventNo);
  public boolean addEvent(MultipartHttpServletRequest multipartRequest) throws  Exception;
}
