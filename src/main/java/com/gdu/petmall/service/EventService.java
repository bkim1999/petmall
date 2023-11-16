package com.gdu.petmall.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.EventDto;

public interface EventService {
  
  public void loadEventList(HttpServletRequest request, Model model);
  public EventDto loaddetailEventList(int eventNo);
  public int increaseHit(int eventNo);
  public void addEvent(EventDto eventDto,MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) throws  Exception;
  public Map<String, Object> eventImageUpload(MultipartHttpServletRequest multipartRequest);
}
