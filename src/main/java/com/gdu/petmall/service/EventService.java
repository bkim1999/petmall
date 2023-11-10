package com.gdu.petmall.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.gdu.petmall.dto.EventDto;

public interface EventService {
  
  public void loadEventList(HttpServletRequest request, Model model);
  public EventDto loaddetailEventList(int eventNo);
}
