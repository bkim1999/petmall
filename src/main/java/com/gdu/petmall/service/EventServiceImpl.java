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

import com.gdu.petmall.dao.EventMapper;
import com.gdu.petmall.dto.EventDto;
import com.gdu.petmall.util.MyFileUtils;
import com.gdu.petmall.util.MyPageUtils;

import lombok.RequiredArgsConstructor;
import net.coobird.thumbnailator.Thumbnails;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {
  
  private final EventMapper eventMapper;
  private final MyPageUtils myPageUtils;
  private final MyFileUtils myFileUtils;
  
  
  @Transactional(readOnly = true)
  @Override
    public void loadEventList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = eventMapper.getEventCount();
    int display = 12;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end"  , myPageUtils.getEnd());
    
    List<EventDto> eventList = eventMapper.getEventList(map);
    
    model.addAttribute("eventList", eventList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/event/list.do"));
    model.addAttribute("beginNo", total - (page - 1) * display);
    }
  
  @Override
  public EventDto loaddetailEventList(int eventNo) {
    return eventMapper.getEventDetailList(eventNo);
  }
  
  @Override
  public int increaseHit(int eventNo) {
    return eventMapper.updateHit(eventNo);
  }
  
  
  @Override
  public boolean addEvent(MultipartHttpServletRequest multipartRequest) throws Exception {
    
    String title = multipartRequest.getParameter("title");
    String contents = multipartRequest.getParameter("contents");
    String startAt = multipartRequest.getParameter("startAt");
    String endAt = multipartRequest.getParameter("endAt");
    String discountPercent = multipartRequest.getParameter("discountPercent");
    String discountPrice = multipartRequest.getParameter("discountPrice");
    
    List<MultipartFile> files = multipartRequest.getFiles("files");
    
    int attachCount;
    
    if(files.get(0).getSize() == 0) {
      attachCount = 1;
    } else { 
      attachCount = 0;
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
        
        int hasThumbnail = (contentType != null && contentType.startsWith("image")) ? 1 : 0 ;
        
        if(hasThumbnail == 1) {
          File thumbnail = new File(dir, "s_" + filesystemName); 
          Thumbnails.of(file)
                    .size(100, 100)      // 가로 100px, 세로 100px
                    .toFile(thumbnail);  
          
         String  eventThumnailUrl = path+filesystemName;
         
         EventDto eventDto = EventDto.builder()
                                     .title(title)
                                     .contents(contents)
                                     .eventThumnailUrl(eventThumnailUrl)
                                     .startAt(startAt)
                                     .endAt(endAt)
                                     .build();
          
          
        }
        
        
        
      } // if
      
    } // for
    
    return true;
  }
 
      
      
      
      
      
      
      
      
      
      
      
}
