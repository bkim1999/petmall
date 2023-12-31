<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="네이버간편가입" name="title"/>
</jsp:include>

<div>

  <h1 class="title">네이버 간편가입</h1>

  <form id="frm_naver_join" method="post" action="${contextPath}/user/naver/join.do">
  
<!--이메일-->    
    <div>
      <label for="email" >이메일</label>
      <div><input type="text" name="email" id="email"  value="${naverProfile.email}" readonly></div>
    </div>
    
    
<!-- 이름  -->
<div>
  <input type="text" id="name" name="name" placeholder="이름" value="${naverProfile.name}" readonly>
  <div id="msg_name"></div>
</div>


 <div>
      <label for="mobile" >휴대전화번호</label>
      <div class="col-sm-9"><input type="text" name="mobile" id="mobile"  value="${naverProfile.mobile}" readonly></div>
</div>


<!-- 성별 -->
<div>
성별
<label for="no"><input type="radio" id="no" name="gender" value="N" checked>선택안함</label>
<label for="man"><input type="radio" id="man" name="gender" value="M" >남자</label>
<label for="woman"><input type="radio"id="woman" name="gender" value="F">여자</label>
</div>
    <script>
      $(':radio[value=${naverProfile.gender}]').prop('checked', true);
    </script>





<!-- 약관동의 -->
<div>
  <div>회원가입 및 정상적인 서비스 이용을 위해 아래 약관을 읽어보시고 ,동의여부를 결정해 주세요.</div>

  <input type="checkbox" id="chk_all"><label for="chk_all">모두 확인, 동의합니다.</label>

    <div>
      <label for="service_agree"><input type="checkbox"  id="service_agree"  class="chk_each service">[필수]서비스 이용약관 동의</label>
      <button type="button">약관 보기</button>
    </div>
    <div>
      <label for="personal_info"><input type="checkbox"   id="personal_info"  class="chk_each service"  >[필수]개인정보취급방침동의</label> 
      <button type="button">약관 보기</button>
    </div>
  
  <div>
  <label for="event"><input type="checkbox" id="event" name="event" class="chk_each" >[선택]광고성 정보 이메일 수신 동의</label>
  </div>
       
      
      <button type="submit" >회원가입하기(만14세이상)</button>
    </div>
    
  </form>

</div>

<!-- 스크립트 영역 -->
<script>
/* ******************체크박스*************************************   */

//전체 선택을 클릭하면 개별 선택에 영향을 미친다.
const fnChkAll = () => {
$('#chk_all').click((ev) => {
 $('.chk_each').prop('checked', $(ev.target).prop('checked'));
})
}

//개별 선택을 클릭하면 전체 선택에 영향을 미친다.
const fnChkEach = () => {
$(document).on('click', '.chk_each', () => {
 var total = 0;
 $.each($('.chk_each'), (i, elem) => {
   total += $(elem).prop('checked');
 })
 $('#chk_all').prop('checked', total === $('.chk_each').length);
})
}
/****************************네이버 가입 필수 조건 체크**************************************/
   const fnNaverJoin = () => {
    $('#frm_naver_join').submit((ev) => {
      if(!$('.service').is(':checked')){
        alert('이용약관에 동의하세요.');
        ev.preventDefault();
        return;
      }
    })
  }

/* ***********************************호출*******************************************  */
//체크박스
fnChkAll();
fnChkEach();
fnNaverJoin();
</script>

<%@ include file="../layout/footer.jsp" %>