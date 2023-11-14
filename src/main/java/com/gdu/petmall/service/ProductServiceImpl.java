package com.gdu.petmall.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.petmall.dao.ProductMapper;
import com.gdu.petmall.dto.ProductDto;
import com.gdu.petmall.dto.ProductOptionDto;
import com.gdu.petmall.dto.ReviewDto;
import com.gdu.petmall.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ProductServiceImpl implements ProductService {
  
  private final ProductMapper productMapper;
  private final MyPageUtils myPageUtils;
  
  @Override
  public Map<String, Object> loadProductList(HttpServletRequest request) {
    Optional<String> opt = Optional.ofNullable(request.getParameter("categoryNo"));
    int categoryNo = Integer.parseInt(opt.orElse("0"));
    
    int productCount = productMapper.getProductCount(Map.of("categoryNo", categoryNo));
    if(productCount == 0) {
      return Map.of("message", "아직 상품이 준비되지 않았습니다.");
    }

    opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int display = 10;
    myPageUtils.setPaging(page, productCount, display);
    int begin = myPageUtils.getBegin();
    int end = myPageUtils.getEnd();
    
    opt = Optional.ofNullable(request.getParameter("order"));
    String order = opt.orElse("PRODUCT_NAME");
    opt = Optional.ofNullable(request.getParameter("ascDesc"));
    String ascDesc = opt.orElse("ASC");
    
    Map<String, Object> map = Map.of("categoryNo", categoryNo
                                   , "order", order
                                   , "ascDesc", ascDesc
                                   , "begin", begin
                                   , "end", end);
    
    List<ProductDto> productList = productMapper.getProductList(map);
    
    return Map.of("productList", productList
                , "totalPage", myPageUtils.getTotalPage());
    
  }
  
  @Override
  public void loadProductInfo(HttpServletRequest request, Model model) {
    int productNo = Integer.parseInt(request.getParameter("productNo"));
    ProductDto product = productMapper.getProduct(productNo);
    List<ProductOptionDto> optionList = productMapper.getOptionList(productNo);
    
    model.addAttribute("product", product);
    model.addAttribute("optionList", optionList);
    
  }
  
  @Override
  public void addProduct(ProductDto product, Model model) {
    int addProductResult = productMapper.insertProduct(product);
    model.addAttribute("addProductResult", addProductResult);
  }
  
  public Map<String, Object> loadReviewList(HttpServletRequest request) {
    int productNo = Integer.parseInt(request.getParameter("productNo"));
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int reviewCount = productMapper.getProductReviewCount(productNo);
    int display = 10;
    myPageUtils.setPaging(page, reviewCount, display);
    
    opt = Optional.ofNullable(request.getParameter("order"));
    String order = opt.orElse("");
    
    
    Map<String, Object> map = Map.of("productNo", productNo
                                   , "order", order
                                   , "begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<ReviewDto> reviewList = productMapper.getProductReviewList(map);
    
    return Map.of("reviewList", reviewList
                , "paging", myPageUtils.getAjaxPaging());
  }
  
}
