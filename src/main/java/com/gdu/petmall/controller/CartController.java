package com.gdu.petmall.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.CartDto;
import com.gdu.petmall.dto.ProductOptionDto;
import com.gdu.petmall.dto.UserDto;
import com.gdu.petmall.service.CartService;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Controller
public class CartController {

  private final CartService cartService;
  
  
  
  @GetMapping(value="/order/cart.go")
  public String cartList(HttpServletRequest request, Model model) {
   cartService.getList(request, model);
   return "/order/cart";
  }
  
  @PostMapping(value="/order/")
  @ResponseBody
  public String addCart(HttpServletRequest request, CartDto cartDto) {
    int addResult = cartService.addCart(request, cartDto);
    return "";
  }
  
  @ResponseBody
  @PostMapping(value="/order/delete.do" , produces="application/json")
  public int removeCart(int optionNo) {
   return cartService.removeCart(optionNo);
  }

  
  
//  @PostMapping("/order/delete.do")
//  public String removeCart(@RequestParam(value="optionNo", required=false, defaultValue="0") int optionNo
//                     , RedirectAttributes redirectAttributes) {
//    int removeResult = cartService.removeCart(optionNo);
//    redirectAttributes.addAttribute("removeResult", removeResult);
//    return "redirect:/order/cart.go";
// }
  






}
