package com.gdu.petmall.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.EventDto;
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
    EventDto event = eventService.loaddetailEventList(eventNo);
    model.addAttribute("event",event);
    return "event/detail";
  }
  
  @GetMapping("/increase.do")
  public String increaseHit(@RequestParam(value="eventNo", required = false , defaultValue = "0") int eventNo) {
    eventService.increaseHit(eventNo);
    return "redirect:/event/detail.do?eventNo=" + eventNo;
  }
  
  @GetMapping("/write.do")
  public String writeEvent() {
    return "event/write";
  }
  
  @PostMapping("/add.do")
  public String addEvent(MultipartHttpServletRequest multiparRequest
                      ,  RedirectAttributes redirectAttributes) throws  Exception{
    boolean addResult = eventService.addEvent(multiparRequest);
    redirectAttributes.addFlashAttribute("addResult", addResult);
    return "redirect:/event/list.do";
  }
  
  
  
  
}
