package com.gdu.petmall.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.ProductDto;
import com.gdu.petmall.dto.ProductImageDto;


public interface ProductService {
  public Map<String, Object> loadProductList(HttpServletRequest request);
  public void loadProductInfo(HttpServletRequest request, Model model);
  public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest);
  public void addProduct(ProductDto product, MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) throws Exception;
  public Map<String, Object> loadReviewList(HttpServletRequest request);
  public List<ProductImageDto> loadProductImageList(HttpServletRequest request);
}
