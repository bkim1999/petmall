package com.gdu.petmall.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dao.ReviewMapper;
import com.gdu.petmall.dto.ReviewDto;
import com.gdu.petmall.util.MyFileUtils;
import com.gdu.petmall.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReviewServiceImpl implements ReviewService {
  
  private final ReviewMapper reviewMapper;
  private final MyPageUtils myPageUtils;
  private final MyFileUtils myFileUtils;
  
  
  public Map<String, Object> loadReviewList(HttpServletRequest request) {
    int productNo = Integer.parseInt(request.getParameter("productNo"));
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int reviewCount = reviewMapper.getProductReviewCount(productNo);
    int display = 10;
    myPageUtils.setPaging(page, reviewCount, display);
    
    opt = Optional.ofNullable(request.getParameter("order"));
    String order = opt.orElse("");
    
    
    Map<String, Object> map = Map.of("productNo", productNo
                                   , "order", order
                                   , "begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<ReviewDto> reviewList = reviewMapper.getProductReviewList(map);
    
    return Map.of("reviewList", reviewList
                , "paging", myPageUtils.getAjaxPaging());
  }
  
  @Override
  public void addReview(ReviewDto review, RedirectAttributes redirectAttributes) {
    reviewMapper.insertProductReview(review);
  }
  
  
}
