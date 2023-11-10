package com.gdu.petmall.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.petmall.dao.EventMapper;
import com.gdu.petmall.dto.EventDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {
  
  private final EventMapper eventMapper;
  
  
  @Override
    public void loadEventList(HttpServletRequest request, Model model) {
    List<EventDto> eventList = eventMapper.getEventList();
    
    model.addAttribute("eventList", eventList);
      
    }
  
  @Override
  public EventDto loaddetailEventList(int eventNo) {
    return eventMapper.getEventDetailList(eventNo);
  }
  
}
