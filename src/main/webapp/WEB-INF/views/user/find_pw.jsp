<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="아이디 찾기" name="title"/>
</jsp:include>

<div>
<h1>비밀번호 변경</h1>


<form  id="frm_change_pw">
  <div>
    <label for="email" >이메일</label>
    <input type="text"  id="email" name="email">
  </div>
  
  
 <div><button id="btn_change_pw" type="button">비밀번호 변경</button></div>
  
</form>


    



<!-- 스크립트 영역 -->

<script>

/* **************************컨텍스트 패스**************************** */
const getContextPath = () => {
  let begin = location.href.indexOf(location.host) + location.host.length;
  let end = location.href.indexOf('/', begin + 1);
  return location.href.substring(begin, end);
}

/****************************아이디찾기**********************************/
const fnFindId=()=>{
	
	$('#btn_change_pw').click(()=>{
		
		$.ajax({
			type:'post',
			url:getContextPath() +'/user/find_pw.do',
			data:$('#frm_find_pw').serialize(),
			
			dataType:'json',
			success:(resData)=>{
				
				if(resData.pw==0)
				{
					alert('일치하는 회원정보가 없습니다.');
					return;
				}
				
				//새 비번 설정 페이지로 보냄. (sha256은 복호화 불가능)
			}
		})
	})
}


fnFindId();

</script>


</div>



<%@ include file="../layout/footer.jsp" %>


    

