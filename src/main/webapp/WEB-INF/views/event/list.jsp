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
 div {
  color: #255255255;
 }
</style>

  <div>나는야 이벤트 게시판</div>
  <div>
   <c:forEach items="${eventList}" var="event" varStatus="vs">
    <div>
      <a href="${contextPath}/event/detail.do?eventNo=${event.eventNo}"><img src="${event.eventThumnailUrl}" width=300px height=300px></a>
    </div>
   </c:forEach>
  </div>
  
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