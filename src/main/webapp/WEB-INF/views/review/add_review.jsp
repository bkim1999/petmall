<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="리뷰 작성" name="title"/>
</jsp:include>


<style>
  .ck.ck-editor {
    max-width: 1000px;
  }
  .ck-editor__editable {
    min-height: 400px;
  }
  .ck-content {
    color: gray;
  }
</style>

<div>
  
  <form id="frm_add_review" method="post" action="${contextPath}/review/addReview.do" enctype="multipart/form-data">
    <h1>상품 리뷰</h1>
    <div>상품명: ${productName} (${optionName})</div>
    <div>
      <label for="reviewRating">평점</label>
      <input type="text" name="reviewRating" id="reviewRating" class="review_input">
    </div>
    <div>
      <label for="reviewTitle">제목</label>
      <input type="text" name="reviewTitle" id="reviewTitle" class="review_input">
    </div>
    <div>
      <label for="reviewContents">내용</label>
      <textarea name="reviewContents" id="reviewContents" class="review_input"></textarea>
    </div>
    <div class="mt-3">
      <label for="files" class="form-label">사진첨부</label>
      <input type="file" name="review_images" id="review_images" class="form-control">
    </div>
    <div>
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      <input type="hidden" name="productNo" value="${productNo}">
      <input type="hidden" name="optionNo" value="${optionNo}">
      <button type="submit">작성</button>
    </div>
    
  </form>

</div>


<script>
  
  const fnCheckRequired = () => {
    $('#frm_add_review').submit((ev) => {
      $.each($('.review_input'), (i, input) => {
        if($.trim($(input).val()) === ''){
          alert('빈칸에 내용을 입력해주세요.');
          ev.preventDefault();
          return;
        }
      });
      var files = $('#review_images').prop('files');
      for(let i = 0; i < files.length; i++){
        var filetype = files[i].type;
        if(filetype.substring(0, filetype.indexOf('/')) !== 'image'){
          alert('썸네일은 이미지파일만 넣어주세요.');
          ev.preventDefault();
          return;
        }
      }
    });
  }
  
  const fnFileCheck = () => {
    $('#review_images').change((ev) => {
      let maxSize = 1024 * 1024 * 100;
      let maxSizePerFile = 1024 * 1024 * 10;
      let totalSize = 0;
      let files = ev.target.files;
      for(let i = 0; i < files.length; i++){
        totalSize += files[i].size;
        if(files[i].size > maxSizePerFile){
          alert('각 첨부파일의 최대 크기는 10MB입니다.');
          $(ev.target).val('');
          return;
        }
      }
      if(totalSize > maxSize){
        alert('전체 첨부파일의 최대 크기는 100MB입니다.');
        $(ev.target).val('');
        return;
      }
    });
  }
  
  fnCheckRequired();
  fnFileCheck();
  
</script>

<%@ include file="../layout/footer.jsp" %>