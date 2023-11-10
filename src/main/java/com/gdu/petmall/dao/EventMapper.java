package com.gdu.petmall.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.petmall.dto.EventDto;

@Mapper
public interface EventMapper {
  
  public List<EventDto> getEventList();
  public EventDto getEventDetailList(int eventNo);
}
