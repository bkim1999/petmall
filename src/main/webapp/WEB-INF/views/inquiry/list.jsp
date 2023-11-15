<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="문의" name="title"/>
</jsp:include>

  <div class="text-center">
    <a href="${contextPath}/inquiry/write.form">
      <button type="button">문의하기</button>
    </a>   
  </div>
  <br>
  
  <div id="inquiry_list" class="inquiry_list">
    <table border="1" style="margin: auto;">
      <thead>
        <tr>
          <td>번호</td>
          <td>제목</td>
          <td>작성일자</td>         
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${inquiryList}" var="i" varStatus="vs">
        <tr>
            <td>${vs.index+1}</td>
            <td><a href="${contextPath}/inquiry/detail.do?inquiryNo=${i.inquiryNo}">${i.title}</a></td>
            <td>${i.createdAt}</td>    
        </tr>    
        </c:forEach>
      </tbody>
    </table>
  </div>



<%@ include file="../layout/footer.jsp" %>