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

<div class="wrap wrap_6">

  <h1 class="title">INQUIRY</h1>
  
  <form id="frm_inquiry_add" method="post" action="${contextPath}/inquiry/add.do" enctype="multipart/form-data">
    <div class="mt-3">
      <select name="title">업종 구분
        <option value="1">동물병원</option>
        <option value="2">펫샵(애견용품점)</option>
        <option value="3">도매</option>
        <option value="4">온라인몰</option>
        <option value="5">약국</option>
        <option value="6">마트</option>
        <option value="7">기타</option>
      </select>
    </div>
    <div class="mt-3">
      <label for="contents" class="form-label"></label>
      <textarea rows="80" name="contents" id="contents" class="form-control"></textarea>
    </div>
    
    <div class="mt-3">
      <label for="files1" class="form-label">첨부파일1</label>
      <input type="file" name="files1" id="files1" class="form-control" multiple>
    </div>
    <div class="mt-3">
      <label for="files2" class="form-label">첨부파일2</label>
      <input type="file" name="files2" id="files2" class="form-control" multiple>
    </div>
    <div class="mt-3">
      <label for="files3" class="form-label">첨부파일3</label>
      <input type="file" name="files3" id="files3" class="form-control" multiple>
    </div>
    <div class="mt-3">
      <label for="files4" class="form-label">첨부파일4</label>
      <input type="file" name="files4" id="files4" class="form-control" multiple>
    </div>
    <div class="mt-3">
      <label for="files5" class="form-label">첨부파일5</label>
      <input type="file" name="files5" id="files5" class="form-control" multiple>
    </div>
    <div class="iattached_list mt-2" id="iattached_list"></div>
    <div class="text-center mt-5">
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      <button type="submit" class="btn btn-primary">등록</button>
      <a href="${contextPath}/inquiry/list.do">
        <button class="btn btn-secondary" type="button">취소</button>
      </a>
      <a href="${contextPath}/inquiry/list.do">
        <button class="btn btn-secondary" type="button">목록</button>
      </a>
    </div>
  </form>
  
</div>
  
<script>

  const fnFileCheck1 = () => {
    $('#files1').change((ev) => {
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
  
  const fnFileCheck2 = () => {
    $('#files2').change((ev) => {
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
  
  const fnFileCheck3 = () => {
    $('#files3').change((ev) => {
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
  
  const fnFileCheck4 = () => {
    $('#files4').change((ev) => {
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
  
  const fnFileCheck5 = () => {
    $('#files5').change((ev) => {
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
	  $('#frm_upload_add').submit((ev) => {
		  if($('#title').val() === ''){
			  alert('제목은 반드시 선택해야 합니다.');
			  $('#title').focus();
			  ev.preventDefault();
			  return;
		  }
	  })
  }
  
  fnFileCheck1();
  fnFileCheck2();
  fnFileCheck3();
  fnFileCheck4();
  fnFileCheck5();
  fnSubmit();
  
</script>
  
<%@ include file="../layout/footer.jsp" %>
