<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="이벤트게시판" name="title"/>
</jsp:include>

<script>
// 전역 변수
var categoryNo = 0;
var page = 1;
var order = 'PRODUCT_NAME';
var ascDesc = 'ASC';
var totalPage = 0;

  $(function(){
   fnGetProductList();
  })

const fnGetProductList = () => {
  $.ajax({
    // 요청
    type: 'get',
    url: '${contextPath}/admin/product_list.do',
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
        str += '<div class="product_thumbnail">사진';
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
</script>

  <div>재고 관리 페이지에 오신걸 환영합니다.</div>
  
  <div>
    <table border=1>
     <thead>
      <tr>
        <td>제품 번호</td>
        <td>제품 이름</td>
        <td>제품 카테고리</td>
        <td>제품 수량</td>
      </tr>
     </thead>
    </table>
  </div>


<%@ include file="../layout/footer.jsp" %>