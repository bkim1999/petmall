package com.gdu.petmall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.petmall.dto.ProductDto;
import com.gdu.petmall.dto.ProductOptionDto;
import com.gdu.petmall.dto.ReviewDto;

@Mapper
public interface ProductMapper {
  public int getProductCount(Map<String, Object> map);
  public List<ProductDto> getProductList(Map<String, Object> map);
<<<<<<< HEAD
  public int insertProduct (ProductDto product);
  public ProductDto getProduct(int productNo);
  public List<ProductOptionDto> getOptionList(int productNo);
  public List<ReviewDto> getReviewList(int productNo);
<<<<<<< HEAD
}
=======
=======
  public ProductDto getProduct(int productNo);
  public List<ProductOptionDto> getOptionList(int productNo);
  public int insertProduct (ProductDto product);
  public List<ReviewDto> getProductReviewCount(int productNo);
  public List<ReviewDto> getProductReviewList(int productNo);
>>>>>>> product
}
>>>>>>> master
