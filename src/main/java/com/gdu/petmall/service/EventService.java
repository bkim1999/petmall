package com.gdu.petmall.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface EventService {
  
  public void loadEventList(HttpServletRequest request, Model model);
  public void loaddetailEventList(int eventNo, Model model);
  
}
