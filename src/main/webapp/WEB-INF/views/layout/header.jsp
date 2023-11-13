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
<!-- bootstrap.min.css -->
<link rel="stylesheet" href="${contextPath}/resources/assets/css/bootstrap.min.css?dt=${dt}">
<link rel="stylesheet" href="${contextPath}/resources/assets/css/style.css?dt=${dt}">
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>

<body>

<div class="header-area">
 <nav class="navbar navbar-default bootsnav" data-minus-value-desktop="70">
  <div class="container">
      <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse"
              data-target="#navbar-menu">
              <i class="fa fa-bars"></i>
          </button>
          <a class="navbar-brand" href="${contextPath}/main.do">메인<span>페이지</span></a>
      </div>

   <div class="collapse navbar-collapse menu-ui-design" id="navbar-menu">
      <ul class="nav navbar-nav navbar-right" data-in="fadeInDown" data-out="fadeOutUp">
        <c:if test="${sessionScope.user.state == 1}">
          <li><a href="${contextPath}/admin/admin.go">관리자페이지</a></li>
        </c:if>
          <!-- 로그인 여부에 따라 바뀔것-->
        <c:if test="${sessionScope.user == null}">
           <li><a href="${contextPath}/user/login.form">login</a></li>
           <li><a href="${contextPath}/user/join_option.form">join</a></li>       
        </c:if>
        <c:if test="${sessionScope.user != null}">      
          <li><a href="${contextPath}/user/mypage">mypage</a></li>
          <li><a href="${contextPath}/user/logout.do">logout</a></li>
          <li class="scroll"><a href="${contextPath}/order/cart.go">장바구니</a></li>
        </c:if>
      
        <li class="scroll"><a href="${contextPath}/product/list.do">상품</a></li>
        <li class="scroll"><a href="${contextPath}/event/list.do">이벤트</a></li>
        <li class="scroll"><a href="${contextPath}/qna/list.do">고객센터</a></li>
        <li class="scroll"><a href="${contextPath}/inquiry/list.do">문의</a></li>
      </ul>
     </div>
   </div>
  </nav>
</div>

<div class="main_wrap">
    <!-- 내용 삽입 -->
</div>

</body>
</html>