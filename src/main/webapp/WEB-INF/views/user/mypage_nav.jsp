<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />



<div>
  <nav class="navbar navbar-expand-lg bg-light" data-bs-theme="light">
  <div class="container-fluid">
    <a class="navbar-brand" href="${contextPath}/main.do">PetMall</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarColor03">
    
      <ul class="navbar-nav me-auto">
      
        <li class="nav-item">
          <a class="nav-link active" href="${contextPath}/user/mypage">MyPage
            <span class="visually-hidden">(current)</span>
          </a>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" href="#"">Order</a>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/user/mypage/profile.form">Profile</a>
        </li>
        
        <li class="nav-item">
          <form action="${contextPath}/user/mypage/point" method="post">
             <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
             <button class="nav-link">Point</button>
          </form>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/user/myPostList">MyPosts</a>
        </li>


      </ul>
      
    </div>
  </div>
</nav>

</div>


<div>
   <div> 반가워요, <span> ${sessionScope.user.name} </span> 님</div>
   <div> 적립금    <span>${user.point}</span>원</div>
</div>

</div>




    

