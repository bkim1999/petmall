<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="장바구니" name="cart"/>
</jsp:include>

  <div>
    
  </div>

  <h1>Cart</h1>
  <hr>
  
  <div>
    <div>
      <h3>일반상품</h3>
    </div>
    <form id="frm_btn" action="">
      <table border="1">
        <thead>
          <tr>
            <th><input type="checkbox" onclick=""></th>
            <th>이미지</th>
            <th>상품명,상품정보</th>
            <th>판매가</th>
            <th>수량</th>
            <th>적립금</th>
            <th>배송구분</th>
            <th>상품 총 가격</th>
            <th>합계</th>
            <th>선택</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach var="cartProduct" items="${cartList}">
            <tr>
              <td><input type="checkbox"></td>
              <td class="">썸네일이미지</td>
              <td class="">${cartProduct.productDto.productName}</td>
              <td class="">${cartProduct.productDto.productPrice}</td>
              <td class="" >${cartProduct.count}</td>     <!-- 자바스크립트 해야될듯 -->
              <td class="">${cartProduct.userDto.point}</td> <!-- 이거 잘계산해야될듯 -->
              <td class="">3000원</td>
              <td class="">${(cartProduct.productDto.productPrice + cartProduct.productOptionDto.addPrice) * cartProduct.count}</td>
              <td class="">합계+배송비</td>
              <td class="deleteOrder">
               <button class="btn_remove" data-optionNo="${cartProduct.productOptionDto.optionNo}">삭제</button>
              </td>
            </tr>  
          </c:forEach>
        </tbody>
      </table>
    </form>
    
    <div>
      <form action="/order/delete.do" method="post" class="delete_form">
        <input type="hidden" name="optionNo" class="delete_option">
      </form>
    </div>
    
    <script>
    	
    	fnDelete();	
    
    	const fnDelete = () => {
    		$(document).on('click', '.btn_remove', (ev) => {
  			  if(!confirm('상품을 삭제할까요?')){
  				  return;
    			}
    		$.ajax({
    			type: 'post',
				  url: '${contextPath}/order/delete.do',
				  data: 'optionNo',
				  dataType: 'json',
				  success: (resData) => {  // resData = {"removeResult": 1}
					  if(resData.removeResult === 1){
						  alert('상품이 삭제되었습니다.');
						} else {
						  alert('상품삭제를 취소합니다.');
					  }
				  }
			  })
		  })
	  }
    	
    
    
    </script>
    
    
    <hr>
    
    <div>
      <table border="1">
        <thead>
          <tr>
            <th>총상품금액</th>
            <th>총배송비</th>
            <th>결제예정금액</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>상품금액들어갈곳</td>
            <td>배송비 들어갈곳</td>
            <td>총 결제 금액</td>
          </tr>
        </tbody>
      </table>
    </div>
    
    <div>
      <div> 
        <input type="number">
      </div>
    </div>
    
    <div>
      <form method="post">
        <button type="submit" onclick="${contextPath}/order/detail.do">구매</button>
        <button type="submit" onclick="${contextPath}/product/list.do">리스트로돌아가기</button>
      </form>
    </div>
  </div>
  


<script>
    
</script>

<%@ include file="../layout/footer.jsp" %>
