package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;


public interface ProductService {
  public Map<String, Object> loadProductList(HttpServletRequest request);
  public void loadProductInfo(HttpServletRequest request, Model model);
}
