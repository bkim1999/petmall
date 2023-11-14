package com.gdu.petmall.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.ReviewDto;
import com.gdu.petmall.service.ReviewService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/review")
@RequiredArgsConstructor
@Controller
public class ReviewController {
  
  private final ReviewService reviewService;
  
  @ResponseBody
  @GetMapping(value="/getReviewList.do", produces="application/json")
  public Map<String, Object> loadReviewList(HttpServletRequest request){
    return reviewService.loadReviewList(request);
  }
  
  @GetMapping(value="/addReview.form")
  public String addReviewForm() {
    return "/review/add_review";
  }
  
  @PostMapping(value="/addReview.do")
  public String addReview(ReviewDto review, RedirectAttributes redirectAttributes) {
    reviewService.addReview(review, redirectAttributes);
    return "redirect:/product/detail.do?productNo=";
  }
  
  
  
}
