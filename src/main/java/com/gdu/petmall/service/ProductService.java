package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

<<<<<<< HEAD
=======
import com.gdu.petmall.dto.ProductDto;

>>>>>>> product

public interface ProductService {
  public Map<String, Object> loadProductList(HttpServletRequest request);
  public void loadProductInfo(HttpServletRequest request, Model model);
<<<<<<< HEAD
=======
  public void addProduct(ProductDto product, Model model);
  public Map<String, Object> loadReviewList(HttpServletRequest request);
>>>>>>> product
}
