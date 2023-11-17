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

<style>
  #slideshow{
    width: 400px;
    height: 400px;
  }
    height: 100%;
  }
  #product_explanation{
    width: 400px;
    height: 400px;
  }
  #product_header{
    width: 100%;
    height: 600px;
    margin: 100px;
  }
  #product_images img {
    height: 100%;
  }
</style>

<div>
  
  <div id="product_header" class="d-flex justify-content-center">
    <div id="slideshow" class="carousel slide" data-bs-ride="carousel">
      <div id="product_images" class="carousel-inner">
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#slideshow" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#slideshow" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
    
    <div id="product_explanation">
      <div>${product.productName}</div>
      <ul class="nav nav-tabs" role="tablist">
        <li class="nav-item" role="presentation">
          <a class="nav-link" data-bs-toggle="tab" href="#description" aria-selected="false" role="tab" tabindex="-1">설명</a>
        </li>
        <li class="nav-item" role="presentation">
          <a class="nav-link active" data-bs-toggle="tab" href="#size" aria-selected="true" role="tab">규격</a>
        </li>
        <li class="nav-item" role="presentation">
          <a class="nav-link" data-bs-toggle="tab" href="#warning" aria-selected="true" role="tab">경고</a>
        </li>
      </ul>
      <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade" id="description" role="tabpanel">
          <p>${product.productDescription}</p>
        </div>
        <div class="tab-pane fade active show" id="size" role="tabpanel">
          <p>${product.productSize}</p>
        </div>
        <div class="tab-pane fade active show" id="warning" role="tabpanel">
          <p>${product.productWarning}</p>
        </div>
      </div>
    </div>
  </div>
  
  <c:if test="${sessionScope.user.adminAuthorState == 1}">
    
    <form method="post" id="frm_modify_remove">
      <input type="hidden" name="productNo" value="${product.productNo}">
      <button type="button" id="btn_modify" class="btn btn-warning">수정</button>
      <button type="button"  id="btn_remove" class="btn btn-danger">삭제</button>
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
  
  <form method="post" action="${contextPath}/order/addCart.do">
    <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
    <div id="selected_option_list"></div>
    <button type="submit" class="btn btn-success">장바구니 담기</button>
  </form>
  
  <div>${product.productContents}</div>
  <div></div>
  
  
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
        str += '  <button type="button" class="btn btn-link minus_count">-</button>';
        str += '  <input type="hidden" class="option_no" value="' + optionNo + '">';
        str += '  <input type="text" class="count" value="1" readonly>';
        str += '  <button type="button" class="btn btn-link plus_count">+</button>';
        str += '  <input type="text" class="option_price" value="' + (${product.productPrice} + addPrice) + '" readonly>원';
        str += '  <p>' + (${product.productPrice} + addPrice) + '원</p>';
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
            str += '    <button class="btn btn-success">리뷰 작성</button>';
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
  
  const fnGetProductImageList = () => {
	    $.ajax({
	      // 요청
	      type: 'get',
	      url: '${contextPath}/product/getProductImageList.do',
	      data: {'productNo' : '${product.productNo}'},
	      // 응답
	      dataType: 'json',
	      success: (resData) => {  // resData = {"productImageList": []}
	        console.log(resData);
	        if(resData.productImageList === null){
	          alert('이미지 목록 불러오기 실패');
	          return;
	        }
	        if(resData.productImageList.length === 0){
	        	let str = '<div class="carousel-item active">';
            str += '  <img class="d-block w-100" src="#" alt="아직 사진이 없습니다.">';
            str += '</div>';
            $('#product_images').append(str);
	          return;
	        }
	        
	        $.each(resData.productImageList, (i, image) => {
	          let str = '';
	          if(i === 1){
	        	  str += '<div class="carousel-item active">';
	          }
	          else{
	            str += '<div class="carousel-item">';
	          }
	          str += '  <img class="d-block w-100" src="${contextPath}' + image.path + '/' + image.filesystemName +  '">';
	          str += '</div>';
	          $('#product_images').append(str);
	        });
	      }
	    })
      $.ajax({
        // 요청
        type: 'get',
        url: '${contextPath}/product/getProductImageList.do',
        data: {'productNo' : '${product.productNo}'},
        // 응답
        dataType: 'json',
        success: (resData) => {  // resData = {"productImageList": []}
          console.log(resData);
          if(resData.productImageList === null){
            alert('이미지 목록 불러오기 실패');
            return;
          }
          if(resData.productImageList.length === 0){
            let str = '<div class="carousel-item active">';
            str += '  <img class="d-block w-100" src="#" alt="아직 사진이 없습니다.">';
            str += '</div>';
            $('#product_images').append(str);
            return;
          }
          
          $.each(resData.productImageList, (i, image) => {
            let str = '';
            if(i === 1){
              str += '<div class="carousel-item active">';
            }
            else{
              str += '<div class="carousel-item">';
            }
            str += '  <img class="d-block w-100" src="${contextPath}' + image.path + '/' + image.filesystemName +  '">';
            str += '</div>';
            $('#product_images').append(str);
          });
        }
      })
    }
  
  const fnModifyProduct = () => {
	    $('#btn_modify').click(function(ev) {
	      if(confirm('이 상품을 수정하시겠습니까?')){
	    	  $(this).parents('#frm_modify_remove').prop('actions', '${contextPath}/product/modifyProduct.do')
	        $(this).parents('#frm_modify_remove').submit();
	        return;
	      }
	    });
	  }
  
  const fnRemoveProduct = () => {
    $('#btn_remove').click(function(ev) {
      if(confirm('이 상품을 삭제하시겠습니까?')){
        $(this).parents('#frm_modify_remove').prop('action', '${contextPath}/product/removeProduct.do')
        $(this).parents('#frm_modify_remove').submit();
        return;
      }
    });
  }
  
  
  fnAddOption();
  fnDecreaseCount();
  fnIncreaseCount();
  fnGetProductOrderList();
  fnModifyProduct();
  fnRemoveProduct();
  fnGetProductImageList();

  </script>

<%@ include file="../layout/footer.jsp" %>