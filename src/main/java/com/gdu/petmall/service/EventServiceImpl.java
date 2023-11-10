package com.gdu.petmall.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.petmall.dao.EventMapper;
import com.gdu.petmall.dto.EventDto;
import com.gdu.petmall.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {
  
  private final EventMapper eventMapper;
  private final MyPageUtils myPageUtils;
  
  
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
  
 
}
