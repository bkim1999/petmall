package com.gdu.petmall.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

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
  private final SqlSession sqlSession;
  
  
  @Override
  public int modifiyCount(CartDto cartDto) {
   return cartMapper.updateCart(cartDto);
  }
  
  @Override
  public void getList(HttpServletRequest request, Model model) {
    
   int userNo = 1;
   //Integer.parseInt(request.getSession().getAttribute("user").getUserNo());
    List<CartDto> cartList = cartMapper.getCartList(userNo);
    model.addAttribute("cartList", cartList);
  }

  public Map<String, Object> removeCart(HttpServletRequest request) throws Exception {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("optionNo"));
    int optionNo = Integer.parseInt(opt.orElse(null));
    Map<String, Object> map = Map.of("optionNo", cartMapper.deleteCart(optionNo));
    int removeResult = cartMapper.deleteCart(optionNo);
    
    return Map.of("removeResult", removeResult);
    
  }
  
  public Map<String, Object> modifyCart(HttpServletRequest request, CartDto cartDto) {
    
    Map<String, Object> map = new HashMap<>();
    String countParam = request.getParameter("count");
    int count = (countParam != null && !countParam.isEmpty()) ? Integer.parseInt(countParam) : 0;
    
    int userNo = 1;
    //Integer.parseInt(request.getSession().getAttribute("user").getUserNo());
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("optionNo"));
    int optionNo = Integer.parseInt(opt.orElse("0"));
  
    CartDto mdCart = CartDto.builder()
                            .count(count)
                            .userDto(UserDto.builder().userNo(userNo).build())
                            .productOptionDto(ProductOptionDto.builder().optionNo(optionNo).build())
                            .build();

    int modifyResult = cartMapper.updateCart(mdCart);

    map.put("modifyResult", modifyResult);
    return map;
}

  @Override
  public int addCart(CartDto cartDto) {
    // TODO Auto-generated method stub
    return 0;
  }
  
  //@Override
  //public int addCart(HttpServletRequest request, CartDto cartDto) {
  // 
  //  HttpSession session = request.getSession();
  //  UserDto user = (UserDto)session.getAttribute("user");
  //  
  //  if(user == null) {
  //    // 로그인페이지로 이동
  //  } 
  //  
  //  int userNo = Integer.parseInt(request.getParameter("userNo"));
  //  int optionNo = Integer.parseInt(request.getParameter("optionNo"));
  //  int count = Integer.parseInt(request.getParameter("count"));
  //  
  //  CartDto cartlist = CartDto.builder()
  //                           .userDto(UserDto.builder().userNo(userNo).build())
  //                           .productOptionDto(ProductOptionDto.builder().optionNo(optionNo).build())
  //                           .count(count)
  //                           .build();
  //  
  //  
  //  
  //  int addResult = cartMapper.insertCart(cartlist);
  //  
  //  return addResult;
  //} 
  
  

  
}
