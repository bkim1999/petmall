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
  <c:if test="${sessionScope.user.adminAuthorState == 1}">
    <form method="post" action="${contextPath}/product/removeProduct.do" id="frm_remove_product">
      <input type="hidden" name="productNo" value="${product.productNo}">
      <button>상품삭제</button>
    </form>
  </c:if>
  
  <c:if test="${not empty optionList}">
    <div>
      <select id="option_list">
        <option value="0">(필수)옵션을 선택해주세요</option>
        <c:forEach var="option" items="${optionList}">
          <option value="${option.optionNo}" data-add-price="${option.addPrice}">
            ${product.productName} ${option.optionName}
            <c:if test="${option.addPrice > 0}">
              (+${option.addPrice})
            </c:if>
          </option>
        </c:forEach>
      </select>
    </div>
  </c:if>
  <div>${product.productContents}</div>
  <div></div>
  
  <form method="post" action="${contextPath}/order/addCart.do">
    <div id="selected_option_list"></div>
  </form>
  
  <div id="order_list"></div>
  
  <div id="review_list"></div>

</div>

<script>
  const fnAddOption = () => {
    $('#option_list').change(function() {
        var optionNo = $(this).val();
        if(optionNo === '0'){
          return;
        }
        var selected_optionNo_list = [];
        $.each($('#selected_option_list').children(), function(i, option) {
          selected_optionNo_list[i] = $(option).data('option-no');
        });
        if ($.inArray(parseInt(optionNo), selected_optionNo_list) !== -1){
          alert('이미 추가된 옵션입니다.');
          $(this).val("0");
          return;
        }
        var optionName = $("#option_list option:selected").text();
        var addPrice = $("#option_list option:selected").data('add-price');
        var str = '<div class="selected_option" data-option-no="' + optionNo + '">';
        str += optionName + '  ';
        str += '  <a class="minus_count">-</a>';
        str += '  <input type="hidden" class="option_no" value="' + optionNo + '">'
        str += '  <input type="text" class="count" value="1" readonly>'
        str += '  <a class="plus_count">+</a>';
        str += '  <input type="text" class="option_price" value="' + (${product.productPrice} + addPrice) + '" readonly>원';
        str += '</div>';
        $('#selected_option_list').append(str);
    });
  }
  
  const fnDecreaseCount = () => {
    $(document).on('click', '.minus_count', function(){
      var count = $(this).siblings('.count');
      if(count.val() === '1'){
        alert('too less')
        return;
      }
        count.val(parseInt(count.val()) - 1);
    });
  }
  
  const fnIncreaseCount = () => {
    $(document).on('click', '.plus_count', function(){
        var count = $(this).siblings('.count');
        if(count.val() === '999'){
          alert('too much')
          return;
        }
          count.val(parseInt(count.val()) + 1);
    });
  }
  
  const fnGetProductOrderList = () => {
	    if('${sessionScope.user.userNo}' === ''){
        $('#order_list').text('로그인 후 리뷰를 작성해주세요.');
        return;
	    }
	    $.ajax({
	      // 요청
	      type: 'get',
	      url: '${contextPath}/review/getProductOrderList.do',
	      data: {'productNo' : '${product.productNo}'
	           , 'userNo' : '${sessionScope.user.userNo}'
	            },
	      // 응답
	      dataType: 'json',
	      success: (resData) => {  // resData = {"productOrderList": []}
	        if(resData.productOrderList === null){
	          alert('사용자의 해당 상품 주문목록 불러오기 실패');
	          return;
	        }
	        if(resData.productOrderList.length === 0){
	          $('#order_list').text('아직 구매하지 않은 상품입니다.');
	          return;
	        }
	        $.each(resData.productOrderList, (i, option) => {
	          let str = '<div class="review_btn" id="' + option.optionNo + '">';
	          str += '  <div>' + option.optionName + '</div>';
	          str += '  <form method="get" action="${contextPath}/review/addReview.form">';
	          str += '    <input type="hidden" name="productNo" value="${product.productNo}">';
	          str += '    <input type="hidden" name="productName" value="${product.productName}">';
	          str += '    <input type="hidden" name="optionNo" value="' + option.optionNo + '">';
	          str += '    <input type="hidden" name="optionName" value="' + option.optionName + '">';
	          str += '    <button>리뷰 작성</button>';
	          str += '</div>';
	          $('#order_list').append(str);
	        });
	      }
	    })

	    fnGetReviewList();
	  }
  
  var page = 1;
  var order = 'REVIEW_CREATED_AT';

  const fnGetReviewList = () => {
    $.ajax({
      // 요청
      type: 'get',
      url: '${contextPath}/review/getReviewList.do',
      data: {'productNo' : '${product.productNo}'
    	     , 'page' : page
           , 'order' : order
            },
      // 응답
      dataType: 'json',
      success: (resData) => {  // resData = {"reviewList": [], "paging": ""}
        if(resData.reviewList === null){
          alert('리뷰 목록 불러오기 실패');
          return;
        }
        if(resData.reviewList.length === 0){
        	$('#review_list').text('아직 리뷰가 없습니다.');
        	return;
        }
        $.each(resData.reviewList, (i, review) => {
        	
        	let str = '<div class="review" data-review-no="' + review.reviewNo + '">';
        	if(review.userNo == '${sessionScope.user.userNo}'){
        		$('#' + review.optionNo).find('button').remove();
        		$('#' + review.optionNo).append('<div>이미 작성한 리뷰입니다.</div>');
        		str += '<button type="button" class="btn_remove_review">삭제</button>';
        	}
          str += '<div>' + review.reviewRating + '</div>';
          str += '<div class="review_thumbnail">';
          str += '  <image src="${contextPath}/' + review.path + '/' + review.filesystemName + '">';
          str += '</div>';
          str += '<div>' + review.reviewTitle+ '</div>'
          str += '<div>' + review.reviewContents + '</div>';
          str += '</div>';
          $('#review_list').append(str);
        });
        $('#review_list').append(resData.paging);
      }
    })
  }
  
  const fnRemoveProduct = () => {
	  $('#frm_remove_product').submit(function(ev) {
		  if(!confirm('이 상품을 삭제하시겠습니까?')){
			  ev.preventDefault();
			  return;
		  }
	  });
  }
  
  
  fnAddOption();
  fnDecreaseCount();
  fnIncreaseCount();
  fnGetProductOrderList();
  fnRemoveProduct();

  </script>

<%@ include file="../layout/footer.jsp" %>