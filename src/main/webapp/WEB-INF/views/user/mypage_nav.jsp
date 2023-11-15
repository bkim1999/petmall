<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />




<!-- 임시 스타일 -->
<style>
.mypage_nav ul li{display: inline-block;}


</style>

<div>
  
  <!-- 마이페이지 네비게이션 -->
<div class="mypage_nav">
  <ul>
    <li><a href="${contextPath}/user/mypage">MyPage</a></li>
    <li><a href="${contextPath}/user/">Order</a></li>
    <li><a href="${contextPath}/user/mypage/profile.form"">Profile</a></li>
    <li>
      <form action="${contextPath}/user/mypage/point" method="post">
        <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
        <button>Point</button>
      </form>
     </li>
    <li><a href="${contextPath}/user/myPostList">MyPosts</a></li>
    <li><a href="${contextPath}/user/">Address</a></li>

  </ul>
</div>


<div>
   <div> 반가워요, <span> ${sessionScope.user.name} </span> 님</div>
   <div> 적립금    <span>${user.point}</span>원</div>
</div>

</div>




    

