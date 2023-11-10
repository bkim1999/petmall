package com.gdu.petmall.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.petmall.dto.InactiveUserDto;
import com.gdu.petmall.dto.UserDto;

@Mapper
public interface UserMapper {

	public UserDto getUser(Map<String, Object>map);
	public int insertAccess(String email);
	public InactiveUserDto getInactiveUser(Map<String, Object> map);
}
