package com.gdu.petmall.dao;

<<<<<<< HEAD
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductMapper {

=======
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
  public int insertProduct (ProductDto product);
  public ProductDto getProduct(int productNo);
  public List<ProductOptionDto> getOptionList(int productNo);
  public List<ReviewDto> getReviewList(int productNo);
>>>>>>> master
}
