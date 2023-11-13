package com.gdu.petmall.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class AdminDto {
  
  private ProductDto productDto;
  private UserDto userDto;
  private LeaveUserDto leaveUserDto;
  private InactiveUserDto inactiveUserDto;
  private QnaDto qnaDto;
  private OrderDto orderDto;
  private InquiryDto inquiryDto;
  private ProductOptionDto productOptionDto;

}
