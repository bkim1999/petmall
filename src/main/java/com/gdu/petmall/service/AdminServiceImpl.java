package com.gdu.petmall.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.petmall.dao.ProductMapper;
import com.gdu.petmall.dao.QnaMapper;
import com.gdu.petmall.dto.QnaDto;
import com.gdu.petmall.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
  
  private final ProductMapper productMapper;
  private final MyPageUtils myPageUtils;
  private final QnaMapper qnaMapper;
  
  @Override
  public void getQna(HttpServletRequest request, Model model) {
    
    List<QnaDto> qnaList = qnaMapper.getAllQnalist();
    
    int checkFlag = 1;
    int qnaTotalCount = qnaMapper.getQnaCount();
    int qnaAnswerCount = qnaMapper.getQnaCount(checkFlag);
    int qnaNonAnswerCount = qnaTotalCount -qnaAnswerCount;
    
    model.addAttribute("qnaList", qnaList);
    model.addAttribute("qnaTotalCount", qnaTotalCount);
    model.addAttribute("qnaNonAnswerCount", qnaNonAnswerCount);
  }
  
    
    
  
}
