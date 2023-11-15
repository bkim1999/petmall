package com.gdu.petmall.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.OrderDto;
import com.gdu.petmall.dto.ReviewDto;


public interface ReviewService {
  public Map<String, Object> loadReviewList(HttpServletRequest request);
  public Map<String, Object> loadProductOrderList(HttpServletRequest request);
  public boolean addReview(int productNo, ReviewDto review, MultipartHttpServletRequest multipartRequest);
}
