package com.gdu.petmall.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.petmall.service.AdminService;
import com.gdu.petmall.service.ProductService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value="/admin")
public class AdminController {
  
  private final AdminService adminService;
  private final ProductService productService;
  
  
  @GetMapping("/admin.go")
  public String adminlist() {
    return "admin/list";
  }
  
  @GetMapping("/product_list.go")
  public String productList() {
    return "admin/product_list";
  }
  
  @GetMapping("/product_list.do")
  public Map<String, Object> productDetailList(HttpServletRequest request, Model model) {
    Map<String, Object> map = productService.loadProductList(request);
    return map;
  }
  

}
