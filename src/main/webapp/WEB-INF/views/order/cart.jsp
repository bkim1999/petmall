<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />
<style>
  .cart_info_td {
    height: 10px;
    margin: 10px;
  }
  
  .totalPrice_span {
    height: 100px;
    margin: 120px;
  }
  
  .b {
    height: 100px;
    margin: 10px;
  }
  .cart_checkbox{
    height: 10px;
    margin: 10px;
  }
</style>

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
    <form id="frm_btn"> 
      <table border="1" class="b">
        <thead>
          <tr>
            <th>이미지 / 상품명 / 판매가 /수량 /적립금 /배송 /상품합계 </th>
          </tr>
        </thead>
        <tbody>
        <caption>장바구니</caption>
          <c:forEach var="cartProduct" items="${cartList}">
            <tr class="a">
              <td class="cart_info_td">
                <input type="checkbox" class="cart_checkbox" checked="checked">
                <input type="" class="image" value="이미지">
                <input type="" class="pr_Name" value="${cartProduct.productDto.productName}">
                <input type="" class="totalPrice" value="${cartProduct.productDto.productPrice}">
                <input type="" class="deliveryPrice" value="3000원">
                <input type="" class="finaltotalprice"value="${(cartProduct.productDto.productPrice + cartProduct.productOptionDto.addPrice) * cartProduct.count + 3000}">
                <input type="" class="" value="적립금">
                <span>
                  <input type="" class="totalCount" value="${cartProduct.count}">
                  <button class="plus_btn">+</button>
                  <button class="minus_btn">-</button>
                </span>
                  <a class="modify_btn" data-Count="${count}"></a>
                <input type="hidden" name="optionNo" class="delete_option" value="${cartProduct.productOptionDto.optionNo}">
                <button type="submit"  class="btn_remove">삭제</button>
              </td>
            </tr>  
          </c:forEach>
        </tbody>
        </table>
      </form>
      
  <hr>
    
    <div>
      <table border="1">
        <thead>
        </thead>
        <tbody>
          <tr>
            <td><span class="totalPrice_span"></span></td>
            <td><span class="totalCount_span"></span></td>
            <td><span class="delivery_price" ></span></td>
            <td><span class="finalTotalPrice_span"></span></td>
          </tr>
        </tbody>
      </table>
      <div>
        <a href="${contextPath}/order/detail.do">
          <button type="button">구매</button>
        </a>
        <a href="${contextPath}/product/list.do">
          <button type="button">리스트로 돌아가기</button>
        </a>
    </div>
   </div>
    
    <form action="${contextPath}/order/modify.do" method="post" class="modify_frm">
      <input type="hidden" name="count" class="modify_count">
      <input type="hidden" name="optionNo" class="modify_optionNo" value="${optionNo}">
    </form>
    
    
 
 </div>

<script>

	var quantity;
	
	$('.plus_btn').on('click', function(){
		quantity = $(this).parent('span').find('input').val();
		$(this).parent('span').find('input').val(++quantity);	
	});
	
	$('.minus_btn').on('click', function(){
		quantity = $(this).parent('span').find('input').val();
			if(quantity > 1){
				$(this).parent('span').find('input').val(--quantity);	
			}
	});
	
	$('.modify_btn').on('click', function(){
		var optionNo = $(this).data('optionNo');
		var count = $(this).parent('span').find('input').val();
		$('.modify_count').val(count);
		$('.modify_optionNo').val(optionNo);
		$('.modify_frm').submit();
		
	});
	
	
	
	
</script>

<script>
	
	$(document).ready(function(){
		 setTotalInfo();
		
	
	$('.cart_checkbox').on('change', function(){
		setTotalInfo($('.cart_info_td'));
	});
	
	function setTotalInfo(){
		
		var totalPrice = 0;				// 총 가격
		var totalCount = 0;				// 총 갯수
		var totalKind = 0;				// 총 종류
		var totalPoint = 0;				// 총 마일리지
		var deliveryPrice = 0;		// 배송비
		var finalTotalPrice = 0; 
	
		$('.cart_info_td').each(function(index, e){
			if($(e).find('.cart_checkbox').is(':checked') === true){
				totalPrice += parseInt($(e).find('.totalPrice').val());
	  		totalCount += parseInt($(e).find('.totalCount').val());
	  		totalKind += 1;
			}
  			
		});
		
		if(totalPrice >= 30000){
			deliveryPrice = 0;
		} else if(totalPrice == 0){
			deliveryPrice = 0;
		} else {
			deliveryPrice = 3000;	
		}
	
		
		finalTotalPrice = totalPrice + deliveryPrice;
		// 총가격
		$('.totalPrice_span').text(totalPrice.toLocaleString());
		// 총 갯수
		$(".totalCount_span").text(totalCount);
		// 총 종류
		$(".totalKind_span").text(totalKind);
		// 배송비
		$(".delivery_price").text(deliveryPrice);	
		// 최종 가격(총 가격 + 배송비)
		$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());
	}
	});

</script>




<script>
	
  const fnModify = (optionNo, count) => {
    $.ajax({
      type: 'post',
      url: '${contextPath}/order/modify.do',
      contentType: 'application/json',
      data: JSON.stringify({
          optionNo: optionNo,
          count: count
      }),
      success: (reseData) => {
    	  
      },
    })
  }
    
    const handleModifyResponse = (response) => {
    	console.log(response);
    };
       
    //fnModify();
    
</script>

<script>
  
  const fnDeleteCart = () => {
  		$(document).on('click', '.btn_remove', (ev) => {
  		  if(!confirm('상품을 삭제할까요?')){
  			  return;
  			}
    		$.ajax({
    			type: 'post',
    		  url: '${contextPath}/order/delete.do',
    		  data: $('#frm_btn').serialize(),
    		  dataType: 'json',
    		  success: (resData) => {  
    			  if(resData.removeResult === 1){
    				  alert('상품삭제를 취소합니다.');
    				  	location.reload();
						} else {
    				  alert('상품이 삭제되었습니다.');
    				  	location.reload();
    			  }
    			}
  			})
  	  })
  	}
		
  fnDeleteCart();
 
</script>


<%@ include file="../layout/footer.jsp" %>
