package com.gdu.petmall.service;

import java.io.File;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
                .title(String.valueOf(title))
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
}
