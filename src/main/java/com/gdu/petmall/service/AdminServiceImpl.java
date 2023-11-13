package com.gdu.petmall.service;

import org.springframework.stereotype.Service;

import com.gdu.petmall.dao.ProductMapper;
import com.gdu.petmall.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
  
  private final ProductMapper productMapper;
  private final MyPageUtils myPageUtils;
  
  
    
    
  
}
