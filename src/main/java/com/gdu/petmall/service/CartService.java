package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.gdu.petmall.dto.CartDto;

public interface CartService {

  public void getList(HttpServletRequest request, Model model);
  public int addCart(HttpServletRequest request, CartDto cartDto);
  public int removeCart(int optionNo);
  public Map<String, Object> modifyCart(HttpServletRequest request,CartDto cartDto);
  
  
}
