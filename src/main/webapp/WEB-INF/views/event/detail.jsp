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


  <div>EVENT</div>
  <hr>
  <div>${eventDetailList.title}</div>
  <div>${eventDetailList.startAt} ~ ${eventDetailList.endAt}</div>
  <hr>
  <div>조회수 ${eventDetailList.hit}</div>
  <hr>
  <div>${eventDetailList.contents}</div>
    <div>${eventDetailList.eventImageDto.path}</div>
    <img src="${eventDetailList.eventImageDto.path}" width = "500px" height = "300px">


<%@ include file="../layout/footer.jsp" %>