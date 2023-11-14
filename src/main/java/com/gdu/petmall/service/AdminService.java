package com.gdu.petmall.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface AdminService {
  
  public void getQna(HttpServletRequest request, Model model);
  
}
