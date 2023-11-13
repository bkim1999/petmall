package com.gdu.petmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gdu.petmall.service.AdminService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value="/admin")
public class AdminController {
  
  private final AdminService adminService;
  
  
  @GetMapping("/admin.go")
  public String loadeventlist() {
    return "admin/list";
  }

}
