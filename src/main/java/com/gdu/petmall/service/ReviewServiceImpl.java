package com.gdu.petmall.service;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dao.ReviewMapper;
import com.gdu.petmall.dto.ProductImageDto;
import com.gdu.petmall.dto.ProductOptionDto;
import com.gdu.petmall.dto.ReviewDto;
import com.gdu.petmall.util.MyFileUtils;
import com.gdu.petmall.util.MyPageUtils;

import lombok.RequiredArgsConstructor;
import net.coobird.thumbnailator.ThumbnailParameter;
import net.coobird.thumbnailator.Thumbnails;

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
    String order = opt.orElse("REVIEW_CREATED_AT");
    
    
    Map<String, Object> map = Map.of("productNo", productNo
                                   , "order", order
                                   , "begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<ReviewDto> reviewList = reviewMapper.getProductReviewList(map);
    
    return Map.of("reviewList", reviewList
                , "paging", myPageUtils.getAjaxPaging());
  }
  
  @Override
  public Map<String, Object> loadProductOrderList(HttpServletRequest request) {
    Optional<String> opt = Optional.ofNullable(request.getParameter("userNo"));
    System.out.println("opt:" + request.getParameter("userNo"));
    int userNo = Integer.parseInt(opt.orElse("0"));
    Map<String, Object> map = Map.of("userNo", userNo
                                   , "productNo", request.getParameter("productNo"));
    List<ProductOptionDto> productOrderList = reviewMapper.getProductOrderList(map);
    return Map.of("productOrderList", productOrderList);
  }
  
  @Override
  public boolean addReview(int productNo, ReviewDto review, MultipartHttpServletRequest multipartRequest) {
    int addReviewResult = reviewMapper.insertProductReview(review);
    reviewMapper.updateProductRating(productNo);
    
    LocalDate today = LocalDate.now();
    String imagePath = "/product/" + DateTimeFormatter.ofPattern("yyyy/MM/dd").format(today);
    List<MultipartFile> reviewImages = multipartRequest.getFiles("review_images");
    
    for(MultipartFile reviewImage : reviewImages) {
      
      if(reviewImage != null && !reviewImage.isEmpty()) {
        // Add Review thumbnails
        String filesystemName = myFileUtils.getFilesystemName(reviewImage.getOriginalFilename());
        File reviewImageFile = new File(imagePath, filesystemName);
        File thumbnailFile = new File(imagePath, "s_" + filesystemName);
        reviewImage.transferTo(reviewImageFile);
        
        Thumbnails.of(reviewImageFile)
                  .size(400, 400)      // 가로 400px, 세로 400px
                  .imageType(ThumbnailParameter.DEFAULT_IMAGE_TYPE)
                  .toFile(thumbnailFile);
        ProductImageDto thumbnailImage = ProductImageDto.builder()
            .imageCode("review_" + review.getReviewNo())
            .position("thumbnail")
            .path(imagePath)
            .filesystemName(filesystemName)
            .build();
        reviewMapper.insertReviewImage(thumbnailImage);

        // Add ProductImageDto(Product images)
        List<MultipartFile> reviewImages = multipartRequest.getFiles("product_images");
        int attachCount;
        if(reviewImages.get(0).getSize() == 0) {
          attachCount = 1;
        } else {
          attachCount = 0;
        }
        
        File dir = new File(imagePath);
        String productImageFilename = myFileUtils.getFilesystemName(reviewImage.getOriginalFilename());
        File tempFile = new File(dir, productImageFilename);
        reviewImage.transferTo(tempFile);

        File productImageFile = new File(dir, "d_" + productImageFilename);
        Thumbnails.of(tempFile)
                  .size(754, 754)      // 가로 754px, 세로 754px
                  .imageType(ThumbnailParameter.DEFAULT_IMAGE_TYPE)
                  .toFile(productImageFile);

        ProductImageDto productImageDto = ProductImageDto.builder()
            .imageCode("product_" + product.getProductNo())
            .position("display")
            .path(imagePath)
            .filesystemName(productImageFilename)
            .build();
        attachCount += productMapper.insertProductImage(productImageDto);
        
      }
      
    }
    
    return (addReviewResult == 1) && (reviewImages.size() == attachCount);
      
    
  }
  
  
}
