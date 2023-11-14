<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마이페이지" name="title"/>
</jsp:include>

<!-- 마이페이지 네비게이션  -->
<h1>POINT</h1>
<jsp:include page="mypage_nav.jsp"></jsp:include>


<!-- 본문  -->
<div>

<table border="1">
  <thead>
    <tr>
      <td>사용가능한 적립금</td>
    </tr>
  </thead>
  <tbody>
      <tr>
      <td>${point}</td>
    </tr>
  </tbody>
</table>
<div>
     <input type="hidden" id="userNo" name="userNo" value="${sessionScope.user.userNo}">
</div>




</div>
<script>
const getContextPath = () => {
  let begin = location.href.indexOf(location.host) + location.host.length;
  let end = location.href.indexOf('/', begin + 1);
  return location.href.substring(begin, end);
}




getContextPath();


</script>
<!----------------------------------------------------------------여기까지 삭제해야함----->


</div>


<%@ include file="../layout/footer.jsp" %>


    

