<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="등록" name="title"/>
</jsp:include>

<style>
  .title {
  width:fit-content;
  margin:auto;
  }
</style>

<div>
  <h1 class="title">INQUIRY</h1>
  
  <br>
   
  <form id="frm_inquiry_add" method="post" action="${contextPath}/inquiry/add.do" enctype="multipart/form-data">
    <div>
    작성자 : ${sessionScope.user.email}     
    </div>
    
    <div>
     제목: <select name="title" id="title" required="required">
            <option label="업종구분" disabled="disabled" selected="selected" hidden></option>
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
      </textarea>
    </div>
    <div>
     공개여부 : <label for="open"><input type="radio" name="post" id="open">공개글</label>
             <label for="secret"><input type="radio" name="post" id="secret">비밀글</label>
    </div>
    <div>
    비밀번호 : <input type="text" name="textPw"  placeholder="●●●●●">
    </div>
    <label for="files">첨부파일</label>
    <input type="file" name="files" id="files" multiple>  
    <input type="hidden" name="userNo" value="${sessionScope.user.userNo}"> 
    <button type="submit" class="btn btn-primary">등록</button>
    <a href="${contextPath}/inquiry/list.do">
      <button class="btn btn-secondary" type="button">취소</button>
    </a>
    <a href="${contextPath}/inquiry/list.do">
      <button class="btn btn-secondary" type="button">목록</button>
    </a>
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
  
  
  const fnSubmit = () => {
	  $('#frm_inquiry_add').submit((ev) => {
		  if($('#title').val() === ''){
			  alert('제목은 반드시 선택해야 합니다.');
			  $('#title').focus();
			  ev.preventDefault();
			  return;
		  }
	  })
  }
  
  fnFileCheck();
  fnSubmit();
  
</script>
  
<%@ include file="../layout/footer.jsp" %>
