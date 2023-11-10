package com.gdu.petmall.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dto.InquiryDto;
import com.gdu.petmall.service.InquiryService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/inquiry")
@RequiredArgsConstructor
@Controller
public class InquiryController {

private final InquiryService inquiryService;
  
  @GetMapping("/list.do")
  public String list() {
    return "inquiry/list";
  }
  
  
  @GetMapping("/write.do")
  public String write() {
    return "inquiry/write";
  }
  
  @PostMapping("/add.do")
  public String add(MultipartHttpServletRequest multipartHttpServletRequest, RedirectAttributes redirectAttributes) throws Exception {
    boolean addResult = inquiryService.addInquiry(multipartHttpServletRequest);
    redirectAttributes.addFlashAttribute("addResult", addResult);
    return "redirect:inquiry/list.do";
  }
  
  @ResponseBody
  @GetMapping(value="/getInquiryList.do", produces="application/json")
  public Map<String, Object> getList(HttpServletRequest request) {
    return inquiryService.getInquiryList(request);
  }
  
  @GetMapping("/detail.do")
  public String detail(HttpServletRequest request, Model model) {
    inquiryService.loadInquiry(request, model);
    return "inquiry/detail";
  }
  
  @GetMapping("/download.do")
  public ResponseEntity<Resource> download(HttpServletRequest request) {
    return inquiryService.download(request);
  }
  
  @GetMapping("/downloadAll.do")
  public ResponseEntity<Resource> downloadAll(HttpServletRequest request) {
    return inquiryService.downloadAll(request);
  }
  
  @PostMapping("/modify.do")
  public String modifyInquiry(InquiryDto inquiry, RedirectAttributes redirectAttributes) {
    int modifyResult = inquiryService.modifyInquiry(inquiry);
    redirectAttributes.addFlashAttribute("modifyResult", modifyResult);
    return "redirect:inquiry/detail.do?inquiryNo=" + inquiry.getInquiryNo();
  }
  
  @PostMapping(value="/addIattach.do", produces="application/json")
  public Map<String, Object> addAttach(MultipartHttpServletRequest multipartHttpServletRequest) throws Exception {
    return inquiryService.addIattach(multipartHttpServletRequest);
  }
  
  @PostMapping(value="/removeInquiry.do")
  public String removeInquiry(@RequestParam(value="inquiryNo", required=false, defaultValue="0") int inquiryNo, RedirectAttributes redirectAttributes) {
    int removeResult =inquiryService.removeInquiry(inquiryNo);
    redirectAttributes.addFlashAttribute("removeResult", removeResult);
    return "redirect:/inquiry/list.do";
  }
  
  @PostMapping(value="/removeIattach.do", produces="application/json")
  public Map<String, Object> removeIattach(HttpServletRequest request) {
    return inquiryService.removeIattach(request);
  }
 
  
}
