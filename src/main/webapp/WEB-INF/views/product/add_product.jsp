<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="상품목록" name="title"/>
</jsp:include>

<div>
  
  <form id="frm_add_product" method="post" action="${contextPath}/product/addProduct.do">
    <div id="product_images">사진</div>
    <h1>상품 추가</h1>
    <div>
      <label for="productName">상품명</label>
      <input type="text" name="productName" id="productName">
    </div>
    <div>
      <label for="productTitle">상품제목</label>
      <input type="text" name="productTitle" id="productTitle">
    </div>
    <div>
      <label for="productDescription">상품설명</label>
      <input type="text" name="productDescription" id="productDescription">
    </div>
    <div>
      <label for="productSize">상품규격</label>
      <input type="text" name="productSize" id="productSize">
    </div>
    <div>
      <label for="productWarning">상품경고</label>
      <input type="text" name="productWarning" id="productWarning">
    </div>
    
    <hr>
    
    <h1>옵션 추가</h1>
    
    <button type="submit">상품 추가</button>
    
  </form>

</div>

<script>
</script>

<%@ include file="../layout/footer.jsp" %>