   package com.gdu.petmall.service;
   
   import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
   import org.springframework.transaction.annotation.Transactional;
   import org.springframework.web.multipart.MultipartFile;
   import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.petmall.dao.QnaMapper;
   import com.gdu.petmall.dto.ProductDto;
   import com.gdu.petmall.dto.QattachDto;
   import com.gdu.petmall.dto.QnaDto;
   import com.gdu.petmall.dto.UserDto;
   import com.gdu.petmall.util.MyFileUtils;
   import com.gdu.petmall.util.MyPageUtils;
   
   import lombok.RequiredArgsConstructor;
   
   @Transactional
   @RequiredArgsConstructor
   @Service
   public class QnaServiceImpl implements QnaService {
   
       private final QnaMapper qnaMapper;
       private final MyFileUtils myFileUtils;
       private final MyPageUtils myPageUtils;
   
       @Override
       public boolean addQna(MultipartHttpServletRequest multipartRequest) throws Exception {
           int title = 0;
           String titleString = multipartRequest.getParameter("title");
           if (titleString != null && !titleString.isEmpty()) {
               title = Integer.parseInt(titleString);
           }

           String contents = multipartRequest.getParameter("contents");
           String textPw = multipartRequest.getParameter("textPw");

           int userNo = 0;
           String userNoString = multipartRequest.getParameter("userNo");
           if (userNoString != null && !userNoString.isEmpty()) {
               userNo = Integer.parseInt(userNoString);
           }

           int productNo = 0;
           String productNoString = multipartRequest.getParameter("productNo");
           if (productNoString != null && !productNoString.isEmpty()) {
               productNo = Integer.parseInt(productNoString);
           }

           UserDto userDto = UserDto.builder()
                   .userNo(userNo)
                   .build();

           ProductDto productDto = ProductDto.builder()
                   .productNo(productNo)
                   .build();

           QnaDto qna = QnaDto.builder()
                  .title(title)
                  .contents(contents)
                  .textPw(textPw)
                  .userDto(userDto) 
                  .productNo(productNo)
                  .build();

           qnaMapper.insertQna(qna);

           List<MultipartFile> files = multipartRequest.getFiles("files");

           for (MultipartFile multipartFile : files) {
               if (multipartFile != null && !multipartFile.isEmpty()) {
                   String path = myFileUtils.getUploadPath();
                   File dir = new File(path);
                   if (!dir.exists()) {
                       dir.mkdirs();
                   }

                   String originalFilename = multipartFile.getOriginalFilename();
                   String filesystemName = myFileUtils.getFilesystemName(originalFilename);
                   File file = new File(dir, filesystemName);

                   multipartFile.transferTo(file);

                   QattachDto attach = QattachDto.builder()
                           .path(path)
                           .originalFilename(originalFilename)
                           .filesystemName(filesystemName)
                           .qnaNo(qna.getQnaNo())
                           .build();

                   qnaMapper.insertQattach(attach);
               }
           }

           return true;
       }

       
       @Override
       public int getLoggedInUserNo(HttpServletRequest request) {
           HttpSession session = request.getSession();
           if (session.getAttribute("user") != null) {
               UserDto loggedInUser = (UserDto) session.getAttribute("user");
               return loggedInUser.getUserNo();
           } else {
               return -1;
           }
       }
       
       @Override
       public Map<String, Object> myPostList(HttpServletRequest request) {
           String loggedInUserNo = String.valueOf(getLoggedInUserNo(request));

           Map<String, Object> paramMap = new HashMap<>();
           paramMap.put("userNo", loggedInUserNo);

           List<QnaDto> myPostList = qnaMapper.getMyPostList(paramMap);

           Map<String, Object> resultMap = new HashMap<>();
           resultMap.put("myPostList", myPostList);

           return resultMap;
       }
       
       
       @Override
       public QnaDto getQna(int qnaNo) {
           return qnaMapper.getQna(qnaNo);
       }
       
       @Override
       public int removeQna(int qnaNo) {
          return qnaMapper.deleteQna(qnaNo);
       }
       
       @Override
       public int addReply(HttpServletRequest request, RedirectAttributes redirectAttributes) {
           int userNo = getLoggedInUserNo(request);
           int depth = Integer.parseInt(request.getParameter("depth"));
           int groupNo = Integer.parseInt(request.getParameter("groupNo"));

           String contents = request.getParameter("contents");

           qnaMapper.getQna(groupNo);

           int replyDepth = depth + 1;

           QnaDto reply = QnaDto.builder()
                   .contents(contents)
                   .depth(replyDepth)
                   .userDto(UserDto.builder()
                           .userNo(userNo)
                           .build())
                   .groupNo(groupNo)  
                   .build();

           int addReplyResult = qnaMapper.insertReply(reply);

           return addReplyResult;
       }

 
}	