package com.gdu.petmall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.petmall.dto.EventDto;

@Mapper
public interface EventMapper {
  
  public List<EventDto> getEventList(Map<String, Object> map);
  public int getEventCount();
  public EventDto getEventDetailList(int blogNo);
  
}
