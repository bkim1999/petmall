<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="petall" name="title"/>
</jsp:include>


<div>
<!-- <button>카카오로 시작하기</button> -->



<div><a href="${naverLoginURL}" ><img src="${contextPath}/resources/assets/image/btnG_완성형.png" width="200px" ></a></div>
<a href="${contextPath}/user/join.form">가입하기</a>
</div>





<%@ include file="../layout/footer.jsp" %>


    

