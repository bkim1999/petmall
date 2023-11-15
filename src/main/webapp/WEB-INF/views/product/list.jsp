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
  div {
    box-sizing: border-box;
  }
  .product_list {
    width: 1000px;
    margin: 10px auto;
    display: flex;
    flex-wrap: wrap;
  .product {
    width: 400px;
    height: 600px;
    text-align: left;
    padding-top: 100px;
    margin: 20px 10px;
  }
  .product_thumbnail {
    width: 100%;
    width: 400px;
    height: 400px;
  }
  .product:hover {
    cursor: pointer;
  }
</style>

<div>
  
  <h1>상품 목록</h1>
  <div id="product_list" class="product_list"></div>

</div>

<script>

  // 전역 변수
  var categoryNo = 0;
  var page = 1;
  var order = 'PRODUCT_NAME';
  var ascDesc = 'ASC';
  var totalPage = 0;

  const fnGetProductList = () => {
    $.ajax({
      // 요청
      type: 'get',
      url: '${contextPath}/product/getList.do',
      data: {'categoryNo' : categoryNo,
             'page' : page,
             'order' : order,
             'ascDesc' : ascDesc
            },
      // 응답
      dataType: 'json',
      success: (resData) => {  // resData = {"uploadList": [], "totalPage": 10}
        if(resData.productList === null){
          alert(resData.message);
          return;
        }
        totalPage = resData.totalPage;
        $.each(resData.productList, (i, product) => {
          let str = '<div class="product" data-product_no="' + product.productNo + '">';
          str += '<div class="product_thumbnail">';
          str += '  <img src="${contextPath}' + product.productImageDto.path + '/' + product.productImageDto.filesystemName + '">';
          str += '</div>';
          str += '<div>' + product.productName + '</div>'
          str += '<div>' + product.productTitle + '</div>';
          str += '<div>' + product.productPrice + '원</div>';
          str += '<div>리뷰 ' + product.reviewCount + '</div>';
          str += '</div>';
          $('#product_list').append(str);
        });
      }
    })
  }
  
  const fnScroll = () => {
    var timerId;
    $(window).on('scroll', (ev) => {
      if(timerId){
        clearTimeout(timerId);
      }
      timerId = setTimeout(() => {
        
        let scrollTop = $(ev.target).scrollTop();
        let windowHeight = $(ev.target).height();
        let documentHeight = $(document).height();
        
        if(scrollTop + windowHeight + 100 >= documentHeight){
          if(page > totalPage){
            return;
          }
          console.log('페이지 로딩')
          page++;
          fnGetProductList();
        }
      }, 500);
    })
  }

  const fnAddProductResult = () => {
    let addProductResult = '${addProductResult}';  // '', 'true', 'false'
    if(addProductResult !== ''){
      if(addProductResult === '1'){
        alert('성공적으로 업로드 되었습니다.');
      } else {
        alert('업로드가 실패하였습니다.');
      }
    }
  }
  
  const fnDetail = () => {
    $(document).on('click', '.product', function(){
      console.log('clicking upload')      
      location.href = '${contextPath}/product/detail.do?productNo=' + $(this).data('product_no');
    });
  }
  
  fnGetProductList();
  fnScroll();
  fnAddProductResult();
  fnDetail();
  

</script>

<%@ include file="../layout/footer.jsp" %>