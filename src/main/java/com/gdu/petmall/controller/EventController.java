package com.gdu.petmall.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.petmall.service.EventService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/event")
@Controller
@RequiredArgsConstructor
public class EventController {
  
  private final EventService eventService;
  
  @GetMapping("/list.do")
  public String loadeventlist(HttpServletRequest request, Model model) {
    eventService.loadEventList(request, model);
    return "event/list";
  }
  
  @GetMapping("/detail.do")
  public String loadeventdetail(@RequestParam(value="eventNo", required = false , defaultValue = "0") int eventNo, Model model) {
    eventService.loaddetailEventList(eventNo, model);
    return "event/detail";
  }
  
  
}
