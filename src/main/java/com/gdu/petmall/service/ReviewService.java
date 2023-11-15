package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.ReviewDto;


public interface ReviewService {
  public Map<String, Object> loadReviewList(HttpServletRequest request);
  public void addReview(ReviewDto review, RedirectAttributes redirectAttributes);
}
