<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="이벤트게시판" name="title"/>
</jsp:include>






  <div>이벤트글 작성하로왔니?</div>
  
  <div>
    <form method="post" action="${contextPath}/event/add.do" enctype="multipart/form-data">
      <div>
        <label for="title">제목</label>
        <input type="text" name="title" id="title">
      </div>
      
      <div>
        <label id="contents">내용</label>
        <textarea name="contents" id="contents"></textarea>
      </div>
      
      <div>
        <label id="startAt">시작일</label>
        <input type="text" name="startAt"  id="startAt">
        <label id="endAt">종료일</label>
        <input type="text" name="endAt" id="endAt">
      </div>
      
      <div>
        <label id="discountPercent">할인율</label>
        <input type="text" name="discountPercent" id="discountPercent">
      </div>
      
      <div>
        <label id="discountPrice">할인가</label>
        <input type="text" name="discountPrice" id="discountPrice">
      </div>
      
      <hr>
      
      <div>
        <label for="files" class="form-label">1개의 썸네일 첨부</label>
        <input type="file" id="file" name="file" multiple class="form-control">
      </div>
      
      
      <div>
        <input type="hidden" name="userNo">
        <button class="btn btn-primary col-12" type="submit">작성완료</button>
      </div>
      
    </form>
  </div>
  
  


<%@ include file="../layout/footer.jsp" %>