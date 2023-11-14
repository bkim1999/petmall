package com.gdu.petmall.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.petmall.dto.InactiveUserDto;
import com.gdu.petmall.dto.LeaveUserDto;
import com.gdu.petmall.dto.UserDto;

@Mapper
public interface UserMapper {

	public UserDto getUser(Map<String, Object>map);
	public InactiveUserDto getInactiveUser(Map<String, Object> map);
	public LeaveUserDto getLeaveUser(Map<String, Object> map);
  public int getPoint (Map<String, Object>map);
	
	public int insertUser(UserDto user);
	public int insertAccess(String email);
  public int insertLeaveUser(UserDto user);
  public int updateUser(UserDto user);
  public int deleteUser(UserDto user);
 // public int updatePoint(UserDto user); // 포인트 삽입 테스트(추후에 삭제해야할것)
  
}
