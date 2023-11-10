<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="이벤트상세게시판" name="title"/>
</jsp:include>

<style>
 div {
  color: #255255255;
 }
</style>

  <hr>
  <div>${detailResult.title}</div>
  <div>매월 5명</div>
  <hr>
  <div>${detailResult.hit}</div>
  <hr>
  <div></div>



<%@ include file="../layout/footer.jsp" %>