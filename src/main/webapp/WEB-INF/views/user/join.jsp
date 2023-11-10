<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../layout/header.jsp">
  <jsp:param value="join_option" name="title"/>
</jsp:include>

<div>

<h1>회원정보 입력</h1>

<form  method="post"  action="${contextPath}/user/join.do">

<!--개발용 라디오 버튼 admin_author_state -->
<div>
<label for="user"><input type="radio" id="user" name="admin_author_state"  checked>사용자</label>
<label for="admin"><input type="radio"id="admin" name="admin_author_state">관리자</label>
</div>

<hr>


<div>
  <input type="text" id="name"" name="name" placeholder="이름">
</div>

<div>
  <input type="text" id="email"" name="email" placeholder="ID(EMAIL)">
</div>


<div>
  <input type="pw" id="pw"" name="pw" placeholder="비밀번호">
</div>


<div>
  <input type="pw2" id="pw2"  placeholder="비밀번호 확인">
</div>

<div>
  <select id="mobile0" name="mobile">
    <option>010</option>
    <option>011</option>
    <option>016</option>
    <option>017</option>
    <option>018</option>
    <option>019</option>
  </select>
  
  <span>-</span>
  
  <input type="text" id="mobile1" name="mobile"> 
  
   <span>-</span>
  
  <input type="text" id="mobile2" name="mobile"> 
  
  <button type="button">인증번호 받기</button>
</div>




<!-- 약관동의 -->

<div>회원가입 및 정상적인 서비스 이용을 위해 아래 약관을 읽어보시고 ,동의여부를 결정해 주세요.</div>
<button>모두 확인, 동의합니다.</button>

  <div>
    <label for=""><input type="checkbox">[필수]서비스 이용약관 동의</label>
    <button type="button">약관 보기</button>
  </div>
  <div>
    <label for=""><input type="checkbox">[필수]개인정보취급방침동의</label> 
    <button type="button">약관 보기</button>
  </div>
  <div><label for=""><input type="checkbox">[선택]광고성 정보 이메일 수신 동의</label></div>
  <div><label for=""><input type="checkbox">[선택]광고성 정보 SMS 수신 동의</label></div>


<div><button>회원가입하기(만14세이상)</button></div>


</form>

</div>


<%@ include file="../layout/footer.jsp" %>
