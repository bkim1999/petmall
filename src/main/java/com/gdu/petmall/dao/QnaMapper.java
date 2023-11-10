package com.gdu.petmall.dao;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.petmall.dto.QattachDto;
import com.gdu.petmall.dto.QnaDto;

@Mapper
public interface QnaMapper {
	
	public int insertQna(QnaDto qna);
	public int insertQattach(QattachDto qattach);
}
