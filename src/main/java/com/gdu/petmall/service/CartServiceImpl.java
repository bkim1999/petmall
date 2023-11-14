package com.gdu.petmall.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dao.CartMapper;
import com.gdu.petmall.dto.CartDto;
import com.gdu.petmall.dto.ProductOptionDto;
import com.gdu.petmall.dto.UserDto;

import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class CartServiceImpl implements CartService {
  
  private final CartMapper cartMapper;
  
  
  @Override
  public void getList(HttpServletRequest request, Model model) {
    
    int userNo = 1;
      //  Integer.parseInt(request.getSession().getAttribute("user").getUserNo());
    List<CartDto> cartList = cartMapper.getCartList(userNo);
    System.out.println(cartList);
    model.addAttribute("cartList", cartList);
   
  }
 
  @Override
  public int addCart(HttpServletRequest request, CartDto cartDto) {
   
    String productName = request.getParameter("productName");
    
    HttpSession session = request.getSession();
    UserDto user = (UserDto)session.getAttribute("user");
    
    if(user == null) {
      //로그인페이지로 돌아가셈
    }
    
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    int optionNo = Integer.parseInt(request.getParameter("optionNo"));
    int count = Integer.parseInt(request.getParameter("count"));
    
    CartDto cartlist = CartDto.builder()
                             .userDto(UserDto.builder().userNo(userNo).build())
                             .productOptionDto(ProductOptionDto.builder().optionNo(optionNo).build())
                             .count(count)
                             .build();
    
    int addResult = cartMapper.insertCart(cartlist);
    
    return addResult;
  } 
  
  @Override
  public int removeCart(int optionNo) {
    return cartMapper.deleteCart(optionNo);
  }
  
  @Override
  public Map<String, Object> modifyCart(HttpServletRequest request, CartDto cartDto) {
    
    int count = Integer.parseInt(request.getParameter("count"));
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    int optionNo = Integer.parseInt(request.getParameter("optionNo"));
    
    CartDto mdCart = CartDto.builder()
                            .count(count)
                            .userDto(UserDto.builder().userNo(userNo).build())     
                            .productOptionDto(ProductOptionDto.builder().optionNo(optionNo).build())
                            .build();
   
    int modifyResult = cartMapper.updateCart(null);
    
    return Map.of("modifyResult", modifyResult);
  }
  
  
  
  
//  @Override
//  public Map<String, Object> modifyCart(HttpServletRequest request) {
//    
//    int count = Integer.parseInt(request.getParameter("count"));
//    int userNo = Integer.parseInt(request.getParameter("userNo"));
//    int optionNo = Integer.parseInt(request.getParameter("optionNo"));
//    
//    Map<String, Object> mdCart = Map.of("count", count
//                                       , "userNo", userNo
//                                       , "optionNo", optionNo);
//   
//    List<CartDto> modifyResult = cartMapper.updateCart(mdCart);
//   
//   return Map.of("modifyResult",modifyResult);
//  }
  
//  CartDto.builder()
//  .count(count)
//  .userDto(UserDto.builder().userNo(userNo).build())
//  .productOptionDto(ProductOptionDto.builder().optionNo(optionNo).build())
//  .build();
  
  
}
