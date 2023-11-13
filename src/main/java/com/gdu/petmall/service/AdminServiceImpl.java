package com.gdu.petmall.service;

import org.springframework.stereotype.Service;

import com.gdu.petmall.dao.AdminMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
  
  private final AdminMapper adminMapper;

}
