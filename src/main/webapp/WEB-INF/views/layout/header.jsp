<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><c:choose><c:when test="${empty param.title}">마이홈</c:when><c:otherwise>${param.title}</c:otherwise></c:choose></title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js" integrity="sha384-Atwg2Pkwv9vp0ygtn1JAojH0nYbwNJLPhwyoVbhoPwBhjQPR5VtM2+xf0Uwh9KtT" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${contextPath}/resources/assets/css/bootstrap.css?dt=${dt}">
<script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>
</head>

<body>

<div class="header-area">
  
  <nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">PETMALL</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor04" aria-controls="navbarColor04" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarColor01">
        <ul class="navbar-nav me-auto">
          <li class="nav-item">
            <a class="nav-link active" href="${contextPath}/main.do">메인
              <span class="visually-hidden">(current)</span>
            </a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">상품</a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="${contextPath}/product/list.do">전체</a>
              <a class="dropdown-item" href="#">목욕</a>
              <a class="dropdown-item" href="#">위생</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="#">Separated link</a>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${contextPath}/event/list.do">이벤트</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${contextPath}/qna/list.do">고객센터</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${contextPath}/inquiry/list.do">문의</a>
          </li>
        </ul>
        <ul class="navbar-nav d-flex">
          <c:if test="${sessionScope.user.adminAuthorState == 1}">
            <li class="nav-item">
              <a class="nav-link" href="${contextPath}/admin/admin.go">관리자</a>
            </li>
          </c:if>
            <!-- 로그인 여부에 따라 바뀔것-->
          <c:if test="${sessionScope.user == null}">
            <li class="nav-item">
              <a class="nav-link" href="${contextPath}/user/login.form">로그인</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${contextPath}/user/join_option.form">회원가입</a>
            </li>
          </c:if>
          <c:if test="${sessionScope.user != null}">
            <li class="nav-item">
              <a class="nav-link" href="${contextPath}/user/mypage"">내 정보</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${contextPath}/order/cart.go">장바구니</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${contextPath}/user/logout.do">로그아웃</a>
            </li>
          </c:if>
        </ul>
      </div>
    </div>
  </nav>
</div>

<div class="main_wrap">

</body>
</html>