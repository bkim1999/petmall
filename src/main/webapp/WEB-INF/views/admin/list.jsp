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

  <div>관리자 페이지에 오신것을 환영합니다.</div>
  
  <div>제품 재고 관리하로가기</div>
  
  <div>모든 문의글 관리하로가기</div>
  
  <div>총 주문현황 관리하로가기</div>
  
  <div>파트너십 제안 관리하로가기</div>


<%@ include file="../layout/footer.jsp" %>