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
  
  <div id="product_images">사진</div>
  <div>${product.productName}</div>
  <div>${product.productDescription}</div>
  <div>${product.productSize}</div>
  <div>${product.productWarning}</div>
  
  <div>
    <select id="option_list">
      <option value="0">(필수)옵션을 선택해주세요</option>
      <c:forEach var="option" items="${optionList}">
        <option value="${option.optionNo}">
          ${product.productName} ${option.optionName}
          <c:if test="${option.addPrice > 0}">
            (+${option.addPrice})
          </c:if>
        </option>
      </c:forEach>
    </select>
  </div>
  <div></div>
  <div></div>
  
  <form method="post" action="${contextPath}/order/order.do">
    <div id="selected_option_list"></div>
  </form>

</div>

<script>
  const fnAddOption = () => {
	  $('#option_list').change(function() {
        var optionNo = $(this).val();
        if(optionNo === '0'){
        	return;
        }
        var optionName = $("#option_list option:selected").text();
        var str = '<div>';
        str += optionName + '  ';
        str += '  <a>-</a>';
        str += '  <input type="text" class="quantity" data-option_no="' + optionNo + '"value="1" readonly>'
        str += '  <a>+</a>';
        $('#selected_option_list').append(str);
    });
  }
  fnAddOption();
</script>

<%@ include file="../layout/footer.jsp" %>