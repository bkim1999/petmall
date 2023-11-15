<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="${upload.uploadNo}번 게시글" name="title"/>
</jsp:include>

<style>
  .title {
  width:fit-content;
  margin:auto;
</style>

<div>

  <h1 class="title">INQUIRY 수정</h1>
  
  <form id="frm_inquiry_edit" method="post" action="${contextPath}/inquiry/modify.do">
    <div>
    작성자 : ${sessionScope.user.email}     
    </div>
    
    <div>
     제목: <select name="title" id="title">${inquiry.title}
            <option label="업종구분" disabled="disabled" selected="selected"></option>
            <option>동물병원</option>
            <option>펫샵(애견용품점)</option>
            <option>도매</option>
            <option>온라인몰</option>
            <option>약국</option>
            <option>마트</option>
            <option>기타</option>
          </select>
    </div>
    <div>
     내용<br> 
      <label for="contents"></label>
      <textarea rows="50" cols="200"  name="contents" id="contents" 
      placeholder="1. 지역 (국내 / 해외):<br>2. 회사명 :<br>3. 담당자명 / 직급 :<br>4. 연락처 :<br>5. 이메일 :<br>6. 홈페이지 :<br>7. 문의 내용 :<br>8. 회사소개서, 제안서는 첨부파일 부탁드립니다.">
      ${inquiry.contents}</textarea>
    </div>
    <div>
     공개여부 : <label for="open"><input type="radio" name="post" id="open">공개글</label>
             <label for="secret"><input type="radio" name="post" id="secret">비밀글</label>
    </div>
    <div>
    비밀번호 : <input type="text" name="textPw"  placeholder="●●●●●">
    </div>
 
    <!-- 첨부 추가 -->
    <c:if test="${sessionScope.user.userNo == inquiry.userDto.userNo}">
      <h5>신규 첨부</h5>
      <div class="input-group">
        <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
        <input type="file" name="files" id="files" multiple>
        <button type="button" id="btn_add_iattach">첨부추가</button>
      </div>
      <div class="iattached_list" id="iattached_list"></div>
    </c:if>

    <!-- 첨부 목록에서 삭제 -->
    <h5>기존 첨부 목록</h5>
    <div id="iattach_list"></div>

      <div class="text-center my-3">
        <a href="${contextPath}/inquiry/detail.do?inquiryNo=${inquiry.inquiryNo}">
          <button type="submit">취소</button>
        </a>
        <input type="hidden" name="inquiryNo" value="${inquiry.inquiryNo}">
        <button type="submit" id="btn_modify">수정</button>
      </div>
  </form>
</div>  
      
<script>

  const fnFileCheck = () => {
    $('#files').change((ev) => {
      $('#iattached_list').empty();
      let maxSize = 1024 * 1024 * 100;
      let maxSizePerFile = 1024 * 1024 * 10;
      let totalSize = 0;
      let files = ev.target.files;
      for(let i = 0; i < files.length; i++){
        totalSize += files[i].size;
        if(files[i].size > maxSizePerFile){
          alert('각 첨부파일의 최대 크기는 10MB입니다.');
          $(ev.target).val('');
          $('#iattached_list').empty();
          return;
        }
        $('#iattached_list').append('<div>' + files[i].name + '</div>');
      }
      if(totalSize > maxSize){
        alert('전체 첨부파일의 최대 크기는 100MB입니다.');
        $(ev.target).val('');
        $('#iattached_list').empty();
        return;
      }
    })
  }
  
  const fnAddIattach = () => {
    $('#btn_add_iattach').click(() => {
      // 폼을 FormData 객체로 생성한다.
      let formData = new FormData();
      // 첨부된 파일들을 FormData에 추가한다.
      let files = $('#files').prop('files');
      $.each(files, (i, file) => {
        formData.append('files', file);  // 폼에 포함된 파라미터명은 files이다. files는 여러 개의 파일을 가지고 있다.
      })
      // 현재 게시글 번호(uploadNo)를 FormData에 추가한다.
      formData.append('inquiryNo', '${inquiry.inquiryNo}');
      // FormData 객체를 보내서 저장한다.
      $.ajax({
        // 요청
        type: 'post',
        url: '${contextPath}/inquiry/addIattach.do',
        data: formData,
        contentType: false,
        processData: false,
        // 응답
        dataType: 'json',
        success: (resData) => {  // resData = {"attachResult": true}
          if(resData.iattachResult){
            alert('첨부 파일이 추가되었습니다.');
            fnIattachList();
          } else {
            alert('첨부 파일이 추가되지 않았습니다.');
          }
          $('#files').val('');
        }
      })
    })
  }
  
  const fnIattachList = () => {
    $.ajax({
      // 요청
      type: 'get',
      url: '${contextPath}/inquiry/getIattachList.do',
      data: 'inquiryNo=${inquiry.inquiryNo}',
      // 응답
      dataType: 'json',
      success: (resData) => {  // resData = {"attachList": []}
        $('#iattach_list').empty();
        $.each(resData.iattachList, (i, iattach) => {
          let str = '<div class="iattach">';
          if(iattach.hasThumbnail === 0){
        	  str += '<img src="${contextPath}/resources/image/iattach1.png">';
          } else {        	  
            str += '<img src="${contextPath}' + attach.path + '/s_' + attach.filesystemName + '">';
          }
          str += '<span style="margin: 0 10px;">' + attach.originalFilename + '</span>';
          if('${sessionScope.user.userNo}' === '${upload.userDto.userNo}'){            
            str += '<a data-attach_no="' + attach.attachNo + '"><i class="fa-regular fa-circle-xmark ico_remove_attach"></i></a>';
          }
          str += '</div>';
          $('#attach_list').append(str);
        })
      }
    })
  }
  
  const fnRemoveIattach = () => {
    $(document).on('click', '.ico_remove_iattach', (ev) => {
      if(!confirm('해당 첨부 파일을 삭제할까요?')){
        return;
      }
      $.ajax({
        // 요청
        type: 'post',
        url: '${contextPath}/inquiry/removeIattach.do',
        data: 'iattachNo=' + $(ev.target).parent().data('iattach_no'),
        // 응답
        dataType: 'json',
        success: (resData) => {  // resData = {"removeResult": 1}
          if(resData.removeResult === 1){
            alert('해당 첨부 파일이 삭제되었습니다.');
            fnIattachList();
          } else {
            alert('해당 첨부 파일이 삭제되지 않았습니다.');
          }
        }
      })
    })
  }
  
  const fnModifyIattach = () => {
    $('#frm_inquiry_edit').submit((ev) => {
      if($('#title').val() === ''){
        alert('제목은 반드시 입력해야 합니다.');
        $('#title').focus();
        ev.preventDefault();
        return;
      } else if($('#files').val() !== ''){
    	  alert('새로운 첨부가 있는 경우 첨부추가 버튼을 먼저 클릭해 주세요.');
    	  $('#btn_add_iattach').focus();
    	  ev.preventDefault();
        return;
      }
    })
  }
  
  fnFileCheck();
  fnAddIattach();
  fnIattachList();
  fnRemoveIattach();
  fnModifyIattach();
    
</script>
  
<%@ include file="../layout/footer.jsp" %>
