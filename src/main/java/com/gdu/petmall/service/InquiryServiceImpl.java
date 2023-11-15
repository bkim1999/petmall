package com.gdu.petmall.service;

import java.io.File;
import java.nio.file.Files;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.petmall.dao.InquiryMapper;
import com.gdu.petmall.dto.IattachDto;
import com.gdu.petmall.dto.InquiryDto;
import com.gdu.petmall.dto.UserDto;
import com.gdu.petmall.util.MyFileUtils;
import com.gdu.petmall.util.MyPageUtils;

import lombok.RequiredArgsConstructor;


@Transactional
@RequiredArgsConstructor
@Service
public class InquiryServiceImpl implements InquiryService {
  
  private final InquiryMapper inquiryMapper;
  private final MyFileUtils myFileUtils;
  private final MyPageUtils myPageUtils;
  
  @Override
  public boolean addInquiry(MultipartHttpServletRequest multipartRequest) throws Exception {
    
    String title = multipartRequest.getParameter("title");
    String contents = multipartRequest.getParameter("contents");
    int userNo = Integer.parseInt(multipartRequest.getParameter("userNo"));
    String textPw = multipartRequest.getParameter("textPw"); 
    int checkFlag = 1;
    int groupNo = 1;
    
    InquiryDto inquiry = InquiryDto.builder()
                        .title(title)
                        .contents(contents)
                        .userDto(UserDto.builder()
                                  .userNo(userNo)
                                  .build())
                        .textPw(textPw)
                        .checkFlag(checkFlag)
                        .groupNo(groupNo)
                        .build();
    
 
    int inquiryCount = inquiryMapper.insertInquiry(inquiry);
    
    List<MultipartFile> files = multipartRequest.getFiles("files");
    
    int iattachCount;
    if(files.get(0).getSize() == 0) {
      iattachCount = 1;
    } else {
      iattachCount = 0;
    }
    
    for(MultipartFile multipartFile : files) {
      
      if(multipartFile != null && !multipartFile.isEmpty()) {
        
        String path = myFileUtils.getUploadPath();
        File dir = new File(path);
        if(!dir.exists()) {
          dir.mkdirs();
        }
        
        String originalFilename = multipartFile.getOriginalFilename();
        String filesystemName = myFileUtils.getFilesystemName(originalFilename);
        File file = new File(dir, filesystemName);
        
        multipartFile.transferTo(file);
      
        IattachDto iattach = IattachDto.builder()
                            .path(path)
                            .originalFilename(originalFilename)
                            .filesystemName(filesystemName)
                            .build();
        
        iattachCount += inquiryMapper.insertIattach(iattach);
      }
    }
    
    return (inquiryCount == 1) && (files.size() == iattachCount);
  }
  
  @Transactional(readOnly=true)
  @Override
  public void getInquiryList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = inquiryMapper.getInquiryCount();
    int display = 9;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<InquiryDto> inquiryList = inquiryMapper.getInquiryList(map);
    model.addAttribute("inquiryList", inquiryList);
  }
  
  @Transactional(readOnly=true)
  @Override
  public void loadInquiry(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("inquiryNo"));
    int inquiryNo = Integer.parseInt(opt.orElse("0"));
                       
    model.addAttribute("inquiry", inquiryMapper.getInquiry(inquiryNo));
    
  }
  
  @Transactional(readOnly=true)
  @Override
  public InquiryDto getInquiry(int inquiryNo) {
    return inquiryMapper.getInquiry(inquiryNo);
  }
  
  @Override
  public Map<String, Object> getIattachList(HttpServletRequest request) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("inquiryNo"));
    int inquiryNo = Integer.parseInt(opt.orElse("0"));
    
    return Map.of("iattachList", inquiryMapper.getIattachList(inquiryNo));
  }
  
  @Override
  public int modifyInquiry(InquiryDto inquiry) {
    return inquiryMapper.updateInquiry(inquiry);
  }

  
  @Override
  public int removeInquiry(int inquiryNo) {
 
    List<IattachDto> iattachList = inquiryMapper.getIattachList(inquiryNo);
    for(IattachDto iattach : iattachList) {
      
      File file = new File(iattach.getPath(), iattach.getFilesystemName());
      if(file.exists()) {
        file.delete();
      }
      
    }
    
    return inquiryMapper.deleteInquiry(inquiryNo);
  }
  
}
