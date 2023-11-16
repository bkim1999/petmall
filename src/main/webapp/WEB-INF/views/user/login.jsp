<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="로그인" name="title"/>
</jsp:include>


<style>
.login_wrap{margin:0 auto;}

</style>



<div class="logo"><a href="${contextPath}/main.do"><img alt="로고" src=""></a></div>

<div class="login_wrap">







<hr>





<!-- 카카오 로그인 페이지 이동  
<div><button>카카오로 시작하기</button></div>
-->

<!-- 네이버 로그인 페이지 이동  -->
<div><a href="${naverLoginURL}"><img src="${contextPath}/resources/assets/image/btnG_완성형.png" width="200px" ></a></div>


<!-- 로그인 폼  (post)-->
<form method="post" action="${contextPath}/user/login.do" id="frm_login">



<div><input type="text"   id="email"  name="email"  placeholder="ID(Email)"></div>
<div><input type="password"  id="pw" name="pw"  placeholder="PASSWORD"></div>


  <div>
      <input type="hidden" name="referer" value="${referer}">
      <div><button id="btn_login" type="submit">로그인</button></div>
      
  </div>

<span><a href="${contextPath}/user/find_id.form">아이디찾기</a></span>
<span><a href="${contextPath}/user/change_pw.form">비밀번호분실</a></span>
<span><a href="${contextPath}/user/join_option.form">회원가입</a></span>


</form>


</div>



<%@ include file="../layout/footer.jsp" %>


    

