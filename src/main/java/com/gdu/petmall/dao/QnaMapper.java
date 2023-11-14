package com.gdu.petmall.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.petmall.dto.QattachDto;
import com.gdu.petmall.dto.QnaDto;

@Mapper
public interface QnaMapper {
   
   public int insertQna(QnaDto qna);
   public int insertQattach(QattachDto qattach);
   
   public int getQnaCount();
   public List<QnaDto> getQnaList(Map<String, Object> map);
    public List<QnaDto> getMyPostList(Map<String, Object> paramMap);
    
    public QnaDto getQna(int qnaNo);
    
    public int deleteQna(int qnaNo);
    
    public int insertReply(QnaDto qna);
    
    public List<QnaDto> getAllQnalist();
    public int getQnaCount(int checkFlag);
}