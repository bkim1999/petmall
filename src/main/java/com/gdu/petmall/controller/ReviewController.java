package com.gdu.petmall.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
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
  public String addReviewForm(@RequestParam("optionNo") int optionNo, Model model) {
    model.addAttribute("optionNo", optionNo);
    return "/review/add_review";
  }
  
  @ResponseBody
  @GetMapping(value="/getProductOrderList.do", produces="application/json")
  public Map<String, Object> loadProductOrderLlist(HttpServletRequest request){
    return reviewService.loadProductOrderList(request);
  }
  
  @PostMapping(value="/addReview.do")
  public String addReview(int productNo, ReviewDto review, MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) {
    boolean addReviewResult = reviewService.addReview(productNo, review, multipartRequest);
    redirectAttributes.addFlashAttribute("addReviewResult", addReviewResult);
    return "redirect:/product/detail.do?productNo=" + productNo;
  }
  
  
  
}
