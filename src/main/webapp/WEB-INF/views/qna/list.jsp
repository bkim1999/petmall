<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../layout/header.jsp">
  <jsp:param value="문의목록" name="title"/>
</jsp:include>

  <div class="wrap wrap 9">
  <h1>어떠한 목적으로 고객센터를 방문 하셨나요?</h1>
  </div>

<hr>

		<div class="text-center">
		  <div class="d-inline-block mr-3">
		    <a href="${contextPath}/petmall/qna/write.form">
		      <button type="button" class="btn btn-outline-primary">1:1문의글 작성하러가기</button>
		    </a>
		  </div>
		
		  <div class="d-inline-block ml-3">
		    <a href="${contextPath}/petmall/user/myPostList">
		      <button type="button" class="btn btn-outline-primary">내가 작성한 문의글 보러가기</button>
		    </a>
		  </div>
		</div>



<%@ include file="../layout/footer.jsp" %>
