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

<style>

  .Middle {
   margin : 20px;
   border-radius: 10px;
   background-color: white;
  }
  
  .top{
    padding: 30px;
    background-color: #23919770;
  }
  
  .bottom{
    margin : 20px;
    background-color: white;
  }
  
  img {
    width: 600px;
    height: 200px;
    border-radius: 10px;
  }
</style>


  
  <div class="top">
   <c:forEach items="${eventList}" var="event" varStatus="vs">
    <div class="Middle">
      <c:if test="${sessionScope.user.userNo != null}">
       <a href="${contextPath}/event/increase.do?eventNo=${event.eventNo}"><img src="${event.eventThumnailUrl}" width=300px height=300px></a>
      </c:if>
      <c:if test="${sessionScope.user.userNo == null}">
       <a href="${contextPath}/event/detail.do?eventNo=${event.eventNo}"><img src="${event.eventThumnailUrl}" width=300px height=300px></a>
      </c:if>
    </div>
   </c:forEach>
  </div>
  
  <div class="bottom">${paging}</div>
  
  <div>
    <table border="1">
     <thead>
      <tr>
        <td>번호</td>
        <td>제목</td>
        <td>내용</td>
        <td>이미지</td>
      </tr>
     </thead>
     <tbody>
      <c:forEach items="${eventList}" var="event" varStatus="vs">
        <tr>
          <td>${event.eventNo}</td>
          <td>${event.title}</td>
          <td>${event.contents}</td>
          <td>${event.eventThumnailUrl}</td>
        </tr>
      </c:forEach>
     </tbody> 
    </table>
    
  </div>



<%@ include file="../layout/footer.jsp" %>