   <%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   <c:set var="contextPath" value="${pageContext.request.contextPath}" />
   <jsp:include page="../layout/header.jsp">
     <jsp:param value="Q&A 글작성" name="title"/>
   </jsp:include>
   
	
	<div>전체 문의 답변을 기다리는남은 갯수: ${qnaTotalCount}</div>
        
	<div class="table-responsive">
	    <table class="table align-middle">
	        <thead>
	            <tr>
	                <td>순번</td>
	                <td>작성글번호</td>
	                <td>문의한 제품 번호</td>
	                <td>제목</td>
	                <td>작성일자</td>
	                <td>그룹번호</td>
	            </tr>
	        </thead>
	        <tbody>
	         <c:forEach items="${myPostList}" var="post" varStatus="vs">
	               <c:if test="${post.depth eq 0}">            
	             <tr class="align-bottom">
	                 <td>${vs.index + 1}</td>
	                 <td><a href="${contextPath}/user/qnadetail.do?qnaNo=${post.qnaNo}&groupNo=${post.groupNo}">${post.qnaNo}</a></td>
	                    <td>${post.productNo}</td>
	                 <td>${post.title}</td>
	                 <td>${post.createdAt}</td>
	                    <td>${post.groupNo}</td>
	             </tr>
	             </c:if>
	         </c:forEach>
	        </tbody>
	    </table>
	</div> 
	
	<hr>
	

   
   <%@ include file="../layout/footer.jsp" %>
   