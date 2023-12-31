package com.gdu.petmall.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.petmall.dto.CartDto;
import com.gdu.petmall.service.CartService;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Controller
public class CartController {

  private final CartService cartService;
  
  
  @GetMapping(value="/order/detail.do")
  public String orderDetail(HttpServletRequest request, Model model) {
   cartService.getList(request, model);
   return "/order/detail";
  }
  
  @GetMapping(value="/order/cart.go")
  public String cartList(HttpServletRequest request, Model model) {
   cartService.getList(request, model);
   return "/order/cart";
  }
  
  @ResponseBody
  @PostMapping(value="/order/delete.do", produces="application/json")
  public Map<String, Object> removeCart(HttpServletRequest request) throws Exception {
    return cartService.removeCart(request);
  }
  
  @ResponseBody
  @PostMapping(value="/order/modify.do")
  public String upDateCart(CartDto cartDto){
    cartService.modifiyCount(cartDto);
    return "redirect:/order/cart"; 
  } 

//  @ResponseBody
//  @PostMapping(value="/order/modify.do", produces="application/json")
//  public Map<String, Object> modifyCart(@RequestBody CartDto cartDto, HttpServletRequest request) {
//      return cartService.modifyCart(request, cartDto);
//  }

  

}
