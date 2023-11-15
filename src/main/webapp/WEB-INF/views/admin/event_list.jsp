<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="이벤트상세보기" name="title"/>
</jsp:include>

  <table>
    <thead>
      <tr>
        <td>이벤트 번호</td>
        <td>이벤트 이름</td>
        <td>이벤트 사진</td>       
        <td>이벤트 시작일</td>       
        <td>이벤트 종료일</td>       
        <td>이벤트 할인율</td>       
        <td>이벤트 할인가</td>       
        <td>이벤트 종료여부</td>       
        <td>이벤트 상세보기</td>       
      </tr>
    </thead>
    <tbody>
     <c:forEach items="eventList" var="event" varStatus="vs">
      <tr>
        <td>${event.eventNo}</td>
        <td>${event.title}</td>
        <td><img src="${event.eventThumnailUrl}" width ="100px" height="100px"></td>
        <td>${event.startAt}</td>
        <td>${event.endAt}</td>
        <td>${event.discountPercent}</td>
        <td>${event.discountPrice}</td>
        <td>${event.state}</td>
        <td></td>
      </tr>     
     </c:forEach>
    </tbody>
  </table>


<%@ include file="../layout/footer.jsp" %>