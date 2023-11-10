<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마이페이지" name="title"/>
</jsp:include>


<!-- 임시 스타일 -->
<style>
.mypage_nav ul li{display: inline-block;}


</style>


<div class="mypage_nav">
  <ul>
    <li><a href="${contextPath}/user/">MyShop</a></li>
    <li><a href="${contextPath}/user/">Order</a></li>
    <li><a href="${contextPath}/user/">Profile</a></li>
    <li><a href="${contextPath}/user/">Point</a></li>
    <li><a href="${contextPath}/user/myPostList">MyPosts</a></li>
    <li><a href="${contextPath}/user/">Address</a></li>

  </ul>
</div>


<div >

</div>

<%@ include file="../layout/footer.jsp" %>


    

