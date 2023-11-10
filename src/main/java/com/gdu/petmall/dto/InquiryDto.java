package com.gdu.petmall.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class InquiryDto {
  private int inquiryNo;
  private int title;
  private String contents;
  private String createdAt;
  private String textPw;
  private int checkFlag;
  private int status;
  private int depth;
  private int groupNo;
  private UserDto userDto;
}
