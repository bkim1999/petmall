<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="MyProfile" name="title"/>
</jsp:include>

<!-- 마이페이지 네비게이션  -->
<h1>PROFILE</h1>
<jsp:include page="mypage_nav.jsp"></jsp:include>

<!-- 본문  -->
<div>


<form  method="post"  action="${contextPath}/user/mypage/modify.do" id="frm_profile">





<!-- 이메일  -->
<div>

  <div>
      <span>ID</span>
      <input type="text" id="email"" name="email"  value="${sessionScope.user.email}"  readonly>
  </div> 
  

  
</div>

<!-- 이름  -->
<div>
  <span>이름*</span>
  <input type="text" id="name"" name="name" value="${sessionScope.user.name}">
  <div id="msg_name"></div>
</div>

<!-- 성별 -->
<div>
<span>성별 </span>
<label for="no"><input type="radio" id="no" name="gender" value="N" checked>선택안함</label>
<label for="man"><input type="radio" id="man" name="gender" value="M" >남자</label>
<label for="woman"><input type="radio"id="woman" name="gender" value="F">여자</label>
</div>

<!-- 회원이 기존에 선택한값 적용  -->
<script>
$(':radio[value=${sessionScope.user.gender}]').prop('checked',true);
</script>



<!-- 비번/비번확인  -->
<div>

  <div>
   <input type="password" id="pw"" name="pw" placeholder="비밀번호">
   <div id="msg_pw"></div>
  </div>


  <div>
    <input type="password" id="pw2"  placeholder="* 비밀번호 확인">
    <div id="msg_pw2"></div>
</div>


</div>

<!-- 휴대폰 번호  -->
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
  <input type="text" id="mobile1" name="mobile" size="4" maxlength="4" > 
  <span>-</span>
  <input type="text" id="mobile2" name="mobile" size="4" maxlength="4"> 
  <div id="msg_mobile"></div>
</div>

 <!-- String 으로 받은 휴대폰 번호 처리 스크립트 --> 
<script>

/* 전화번호 분리하기  */
var mobile_temp="${sessionScope.user.mobile}";
var mobile0=mobile_temp.substring(0,3);
var mobile1=mobile_temp.substring(3,7);
var mobile2=mobile_temp.substring(7,11);


$('#mobile0').val(mobile0).prop('selected', true);
$('#mobile1').val(mobile1);
$('#mobile2').val(mobile2);
</script>

<!-- 주소 -->
<div>
<input type="text" id="postcode" name="postcode" placeholder="우편번호" value="${sessionScope.user.postcode}" disabled>
<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" ><br>
<input type="text" id="roadAddress"  name="roadAddress" placeholder="도로명주소" value="${sessionScope.user.roadAddress}" disabled>
<input type="text" id="jibunAddress"  name="jibunAddress" placeholder="지번주소"value="${sessionScope.user.jibunAddress}" disabled> 
<span id="guide" style="color:#999;display:none"></span>
<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소"value="${sessionScope.user.detailAddress}" >


<input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목" disabled>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
                
                //상세주소 커서 포커싱
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>


</div>


<!-- 이벤트 수신여부 -->
<div>

<div><label for="event"><input type="checkbox" id="event" name="event" class="chk_each" >[선택]광고성 정보 이메일 수신 동의</label></div>

<script type="text/javascript">
if(${sessionScope.user.agree==1}){$('#event').prop('checked',true);}
else {$('#event').prop('checked',false);}
</script>




<!-- 버튼  -->
 
<div>
<input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
<button type="button" id="btn_modify">회원정보수정</button>
<button type="button" id="btn_cancel">취소</button>
</div>

<div>
<button type="button" id="btn_leave">회원탈퇴</button>
</div>


</div>


</form>
</div>




<!-- 스크립트 영역  -->
<script>



/***********************컨텍스트패스************************************/
const getContextPath = () => {
  let begin = location.href.indexOf(location.host) + location.host.length;
  let end = location.href.indexOf('/', begin + 1);
  return location.href.substring(begin, end);
}

/**********************전역변수 선언*************************************/
var pwPassed = false;
var pw2Passed = false;
var namePassed = true;
var mobilePassed = false;
var mobile1=false;
var mobile2=false;



/**********************정규식*******************************************/
 
 //이름 길이 제한
 const fnCheckName = () => {
  $('#name').blur((ev) => {
    let name = ev.target.value;
    let bytes = 0;
    for(let i = 0; i < name.length; i++){
      if(name.charCodeAt(i) > 128){  // 코드값이 128을 초과하는 문자는 한 글자 당 2바이트임
        bytes += 2;
      } else {
        bytes++;
      }
    }
    namePassed = (bytes <= 50);
    if(!namePassed){
      $('#msg_name').text('이름은 50바이트 이내로 작성해야 합니다.');
    }
  })
}

 
 /* ***************전화번호 정규식 체크 *************************** */
 const fnCheckMobile = () => {
	 
// 휴대전화번호 검사 정규식 
   let regMobile = /^[0-9]{4}$/;
   mobile1=regMobile.test($('#mobile1').val());
   mobile2=regMobile.test($('#mobile2').val());
   mobilePassed = mobile1*mobile2;
	 
   $('#mobile1 ,#mobile2').on('keyup',(ev) => {
   
     ev.target.value = ev.target.value;
     mobile1=regMobile.test($('#mobile1').val());
     mobile2=regMobile.test($('#mobile2').val());
     mobilePassed = mobile1*mobile2;
     
     if(mobilePassed){
       $('#msg_mobile').text('');
     } else {
       $('#msg_mobile').text('휴대전화번호를 확인하세요.');       
     }
   })

 }
 
 
 

 /* ******************************비번 정규식 체크/ 비번 일치여부 확인 ****************************** */
  //비번 정규식 확인 
  const fnCheckPassword = () => {
 	  $('#pw').keyup((ev) => {
 	    let pw = $(ev.target).val();
 	    // 비밀번호 : 8~20자, 영문,숫자,특수문자, 2가지 이상 포함
 	    let validPwCount = /[A-Z]/.test(pw)          // 대문자가 있으면   true
 	                     + /[a-z]/.test(pw)          // 소문자가 있으면   true
 	                     + /[0-9]/.test(pw)          // 숫자가 있으면     true
 	                     + /[^A-Za-z0-9]/.test(pw);  // 특수문자가 있으면 true
 	    pwPassed = pw.length >= 8 && pw.length <= 20 && validPwCount >= 2;
 	    if(pwPassed){
 	      $('#msg_pw').text('사용 가능한 비밀번호입니다.');
 	    } else {
 	      $('#msg_pw').text('비밀번호는 8~20자, 영문/숫자/특수문자를 2가지 이상 포함해야 합니다.');       
 	    }
 	  })
 	}
  
 // 비번 일치여부 확인 
 	const fnCheckPassword2 = () => {
 	  $('#pw2').blur((ev) => {
 	    let pw = $('#pw').val();
 	    let pw2 = ev.target.value;
 	    pw2Passed = (pw !== '') && (pw === pw2);
 	    if(pw2Passed){
 	      $('#msg_pw2').text('');
 	    } else {
 	      $('#msg_pw2').text('비밀번호 입력을 확인하세요.');
 	    }
 	  })
 	}

 

/*************************회원정보 수정******************************/
const fnModifyUser = () => {
  $('#btn_modify').click(() => {
    if(!namePassed){
      alert('이름을 확인하세요.');
      return;
    } else if(!mobilePassed){
      alert('휴대전화번호를 확인하세요.');
      return;
    }else if(!pwPassed || !pw2Passed){
    	 alert('비밀번호를 확인하세요.');
    	return;
    }
    $.ajax({
      // 요청
      type: 'post',
      url: getContextPath() + '/user/mypage/modify.do',
      data: $('#frm_profile').serialize(),
      // 응답
      dataType: 'json',
      success: (resData) => {  // {"modifyResult": 1}
        if(resData.modifyResult === 1){
          alert('회원 정보가 수정되었습니다.');
        } else {
          alert('회원 정보가 수정되지 않았습니다.');
        }
      }
    })
  })
}


/*******************************취소*******************************/
const fnCancel=()=>{
	$('#btn_cancel').click(()=>{
		location.href="${contextPath}/main.do";
	})
}

/*****************************회원탈퇴******************************/
 const fnLeaveUser = () => {
  $('#btn_leave').click(() => {
    if(confirm('회원 탈퇴하시겠습니까?')){
      $('#frm_profile').prop('action', getContextPath() + '/user/mypage/leave.do');
      $('#frm_profile').submit();
    }
  })
}
 

 
/*****************함수호출***********************/



//비번 체크
fnCheckPassword();
fnCheckPassword2();

// 이름 길이 제한
  fnCheckName();
  //폰번호 정규식
  fnCheckMobile();
  
  
  //회언정보 수정
  fnModifyUser();
  //취소
  fnCancel();
  // 탈퇴하기
  fnLeaveUser();

</script>


<%@ include file="../layout/footer.jsp" %>


    

