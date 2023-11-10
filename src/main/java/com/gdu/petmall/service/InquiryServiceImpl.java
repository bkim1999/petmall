package com.gdu.petmall.service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
      
    int title = Integer.parseInt(multipartRequest.getParameter("title"));
    String contents = multipartRequest.getParameter("contents");
    int userNo = Integer.parseInt(multipartRequest.getParameter("userNo"));
    
    InquiryDto inquiry = InquiryDto.builder()
                           .title(title)
                           .contents(contents)
                           .userDto(UserDto.builder()
                                      .userNo(userNo)
                                      .build())
                           .build();
    
    int inquiryCount =inquiryMapper.insertInquiry(inquiry);
    
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
        
        String contentType = Files.probeContentType(file.toPath());  
        
        IattachDto iattach = IattachDto.builder()
                            .iattachNo(iattachCount)
                            .inauiryNo(iattachCount)
                            .path(path)
                            .originalFilename(originalFilename)
                            .filesystemName(filesystemName)
                            .build();
        
        iattachCount += inquiryMapper.insertIattach(iattach);
        
      } 
      
    } 
    
    return (inquiryCount == 1) && (files.size() == iattachCount);
    
  }
  
  
  @Override
  public Map<String, Object> addIattach(MultipartHttpServletRequest multipartRequest) throws Exception {
    
 List<MultipartFile> files =  multipartRequest.getFiles("files");
    
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
        
        String contentType = Files.probeContentType(file.toPath());  
        
        IattachDto iattach = IattachDto.builder()
                              .iattachNo(iattachCount)
                              .inauiryNo(iattachCount)
                              .path(path)
                              .originalFilename(originalFilename)
                              .filesystemName(filesystemName)
                              .build();

        iattachCount += inquiryMapper.insertIattach(iattach);
        
      }  
      
    }  
    
    return Map.of("iattachResult", files.size() == iattachCount);
    
  }
  
  @Transactional(readOnly=true)
  @Override
  public Map<String, Object> getInquiryList(HttpServletRequest request) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = inquiryMapper.getInquiryCount();
    int display = 9;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd());
    
    List<InquiryDto> inquiryList = inquiryMapper.getInquiryList(map);
    
    return Map.of("inquiryList", inquiryList
                , "totalPage", myPageUtils.getTotalPage());
    
  }
  
  @Transactional(readOnly=true)
  @Override
  public void loadInquiry(HttpServletRequest request, Model model) {
   
    Optional<String> opt = Optional.ofNullable(request.getParameter("inquiryNo"));
    int uploadNo = Integer.parseInt(opt.orElse("0"));
    
    model.addAttribute("upload", inquiryMapper.getInquiry(uploadNo));
    model.addAttribute("attachList", inquiryMapper.getIattach(uploadNo));
    
  }
  
  @Override
  public ResponseEntity<Resource> download(HttpServletRequest request) {
    
    int iattachNo = Integer.parseInt(request.getParameter("iattachNo"));
    IattachDto iattach = inquiryMapper.getIattach(iattachNo);
    
    File file = new File(iattach.getPath(), iattach.getFilesystemName());
    Resource resource = new FileSystemResource(file);
    
    if(!resource.exists()) {
      return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
    }
    
    inquiryMapper.updateDownloadCount(iattachNo);
    
    String originalFilename = iattach.getOriginalFilename();
    String userAgent = request.getHeader("User-Agent");
    try {
      if(userAgent.contains("Trident")) {
        originalFilename = URLEncoder.encode(originalFilename, "UTF-8").replace("+", " ");
      }
      else if(userAgent.contains("Edg")) {
        originalFilename = URLEncoder.encode(originalFilename, "UTF-8");
      }
      else {
        originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
      }
    } catch(Exception e) {
      e.printStackTrace();
    }
    
    HttpHeaders header = new HttpHeaders();
    header.add("Content-Type", "application/octet-stream");
    header.add("Content-Disposition", "attachment; filename=" + originalFilename);
    header.add("Content-Length", file.length() + "");
    
    return new ResponseEntity<Resource>(header, HttpStatus.OK);
    
  }
  
  @Override
  public ResponseEntity<Resource> downloadAll(HttpServletRequest request) {
    
    int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
    List<IattachDto> iattachList = inquiryMapper.getIattachList(inquiryNo);
    
    if(iattachList.isEmpty()) {
      return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
    }
    
    File tempDir = new File(myFileUtils.getTempPath());
    if(!tempDir.exists()) {
      tempDir.mkdirs();
    }
    
    String zipName = myFileUtils.getTempFilename() + ".zip";
    
    File zipFile = new File(tempDir, zipName);
    
    ZipOutputStream zout = null;
    
    try {
      
      zout = new ZipOutputStream(new FileOutputStream(zipFile));
      
      for(IattachDto iattach : iattachList) {
        
        ZipEntry zipEntry = new ZipEntry(iattach.getOriginalFilename());
        zout.putNextEntry(zipEntry);
        
        BufferedInputStream bin = new BufferedInputStream(new FileInputStream(new File(iattach.getPath(), iattach.getFilesystemName())));
        zout.write(bin.readAllBytes());
        
        bin.close();
        zout.closeEntry();
        
        inquiryMapper.updateDownloadCount(iattach.getIattachNo());
        
      }
      
      zout.close();
      
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    Resource resource = new FileSystemResource(zipFile);
    
    HttpHeaders header = new org.springframework.http.HttpHeaders();
    header.add("Content-Type", "application/octet-stream");
    header.add("Content-Disposition", "attachment; filename=" + zipName);
    header.add("Content-Length", zipFile.length() + "");
    
    return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
    
    
  }
  
  @Transactional(readOnly=true)
  @Override
  public InquiryDto getInquiry(int inquiryNo) {
    return inquiryMapper.getInquiry(inquiryNo);
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
  
  @Override
  public Map<String, Object> removeIattach(HttpServletRequest request) {
   
    Optional<String> opt = Optional.ofNullable(request.getParameter("iattachNo"));
    int iattachNo = Integer.parseInt(opt.orElse("0"));
    
    IattachDto iattach = inquiryMapper.getIattach(iattachNo);
    File file = new File(iattach.getPath(), iattach.getFilesystemName());
    if(file.exists()) {
      file.delete();
    }
    
    int removeResult = inquiryMapper.deleteIattach(iattachNo);
    
    return Map.of("removeResult", removeResult);
    
  }
}
