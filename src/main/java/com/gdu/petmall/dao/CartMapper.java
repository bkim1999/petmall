package com.gdu.petmall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.petmall.dto.CartDto;

@Mapper
public interface CartMapper {

  public List<CartDto> getCartList(int userNo); 
  
  public int insertCart(CartDto cartDto);
  
  public int deleteCart(int optionNo);
  
  public int updateCart(Map<String, Object> map);
}
