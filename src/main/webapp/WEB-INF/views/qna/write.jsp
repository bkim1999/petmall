	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<jsp:include page="../layout/header.jsp">
	  <jsp:param value="Q&A 글작성" name="title"/>
	</jsp:include>
	
	
	<div class="wrap wrap_6">
	
	<h1>문의글 Q&A 작성하는곳</h1>
	
	
	  
	  <form id="frm_qna_add" method="post" action="${contextPath}/qna/add.do" enctype="multipart/form-data">

		<div class="mt-3">
		  <label for="productNo" class="form-label">제품번호</label>
		  <input type="text" name="productNo" id="productNo" class="form-control" required>
		</div>
	    
		<div class="mt-3">
		  <label for="title" class="form-label">제목</label>
		  <select name="title" id="title" class="form-select">
		    <option value="1">[상품] 상품관련 문의</option>
		    <option value="2">[배송] 배송관련 문의</option>
		    <option value="3">[주문취소] 주문취소 문의</option>
		    <option value="4">[주소변경] 주소변경 문의</option>
		    <option value="5">[반품/환불] 반품/환불 문의</option>
		    <option value="6">[기타] 기타문의</option>
		  </select>
		</div>
		
	    <div class="mt-3">
	      <label for="contents" class="form-label">내용</label>
	      <textarea rows="10" name="contents" id="contents" class="form-control"></textarea>
	    </div>
	    
	    <div class="mt-3">
	      <label for="files" class="form-label">첨부</label>
	      <input type="file" name="files" id="files" class="form-control" multiple>
	    </div>
	    		
	    <div class="mt-3">
	      <label for="textPw" class="form-label">비밀번호</label>
	      <input type="text" name="textPw" id="textPw" class="form-control" multiple>
	    </div>    
	    
		<hr>
		
		<div>추가한 첨부파일</div>
		<div class="attached_list mt-2" id="attached_list"></div>
		<div class="text-center mt-5">
		  <a href="${contextPath}/qna/list.do" class="mr-2">
		    <button class="btn btn-secondary" type="button">작성취소</button>
		  </a>
		  <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
		  <button type="submit" class="btn btn-primary">작성완료</button>
		</div>

	    
	  </form>
	  
	  <hr>
	  
	</div>
	  
	<script>
	
	  const fnFileCheck = () => {
	    $('#files').change((ev) => {
	      $('#attached_list').empty();
	      let maxSize = 1024 * 1024 * 100;
	      let maxSizePerFile = 1024 * 1024 * 10;
	      let totalSize = 0;
	      let files = ev.target.files;
	      for(let i = 0; i < files.length; i++){
	        totalSize += files[i].size;
	        if(files[i].size > maxSizePerFile){
	          alert('각 첨부파일의 최대 크기는 10MB입니다.');
	          $(ev.target).val('');
	          $('#attached_list').empty();
	          return;
	        }
	        $('#attached_list').append('<div>' + files[i].name + '</div>');
	      }
	      if(totalSize > maxSize){
	        alert('전체 첨부파일의 최대 크기는 100MB입니다.');
	        $(ev.target).val('');
	        $('#attached_list').empty();
	        return;
	      }
	    })
	  }
	  
	  const fnSubmit = () => {
		  $('#frm_upload_add').submit((ev) => {
			  if($('#title').val() === ''){
				  alert('제목은 반드시 입력해야 합니다.');
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