package com.gdu.petmall.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.petmall.dto.ProductDto;
import com.gdu.petmall.service.ProductService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/product")
@RequiredArgsConstructor
@Controller
public class ProductController {
  
  private final ProductService productService;
  
  @GetMapping(value="/list.do")
  public String list() {
    return "/product/list";
  }
  
  @ResponseBody
  @GetMapping(value="/getList.do", produces="application/json")
  public Map<String, Object> getList(HttpServletRequest request) {
    return productService.loadProductList(request);
  }
  
  @GetMapping(value="/detail.do")
  public String detail(HttpServletRequest request, Model model) {
    productService.loadProductInfo(request, model);
    return "/product/detail";
  }
  
  @GetMapping(value="/addProduct.form")
  public String addProductForm() {
    return "/product/add_product";
  }
  
  @PostMapping(value="/addProduct.do")
  public String addProduct(@ModelAttribute ProductDto product, Model model) {
    productService.addProduct(product, model);
    return "redirect:product/list.do";
  }
  
}
