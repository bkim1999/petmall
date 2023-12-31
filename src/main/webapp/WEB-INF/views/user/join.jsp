<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="회원가입" name="title"/>
</jsp:include>

<style>
/*중앙 정렬*/
.join_wrap{width:850px; margin:0 auto;}

/*라디오 정렬*/
.test_radio_label{ margin-right:30px; margin-left:10px;}
.gender_radio{margin-right:30px; margin-left:10px;}

/*폼*/
.form-control{margin-bottom:10px;}
.form-select{width: 20%; display: inline;}
.mobile{width:38%; display:inline}

/*주소*/
.


</style>
<h1>회원정보 입력</h1>


<hr>


<div class="join_wrap">


<form  method="post"  action="${contextPath}/user/join.do" id="frm_join">


<!--개발용 라디오 버튼 admin_author_state( 추후에 삭제해야함)  -->
<div>권한</div>
<div  class="form-check">
<label for="user"  class="form-check-label test_radio_label"><input type="radio" id="user" name="admin_author_state" value="0" checked  class="form-check-input">사용자</label>
<label for="admin" class="form-check-label test_radio_label"><input type="radio"id="admin" name="admin_author_state" value="1 "  class="form-check-input">관리자</label>
</div>


<!-- 이름  -->
<div>
이름
</div>
<div>
  <input type="text" id="name"" name="name" placeholder="* 이름" class="form-control">
  <div id="msg_name"></div>
</div>

<!-- 성별 -->
<div>성별</div>
<div class="gender">
<label for="no" class="form-check-label gender_label"><input type="radio" id="no" name="gender" value="N" checked class="form-check-input gender_radio">선택안함</label>
<label for="man" class="form-check-label gender_label"><input type="radio" id="man" name="gender" value="M"  class="form-check-input gender_radio">남자</label>
<label for="woman" class="form-check-label gender_label"><input type="radio"id="woman" name="gender" value="F" class="form-check-input gender_radio">여자</label>
</div>

<!-- 이메일인증  -->
<div>

  <div>
    <div>이메일</div>
      <input type="text" id="email"" name="email" placeholder="* ID(EMAIL)"  class="form-control">
      <button type="button" id="btn_get_code" class="form-control">인증코드받기</button>
      <div id="msg_email"></div>
  </div> 
  
  <div>
  <div>이메일 인증</div>
      <input type="text" id="verify_code" placeholder="인증코드입력" disabled class="form-control"> 
      <button type="button" id="btn_verify_code" disabled class="form-control">인증하기</button>
  </div>
  
</div>

<!-- 비번/비번확인  -->
<div>비밀번호</div>
  <div>
  <div>
   <input type="password" id="pw"" name="pw" placeholder="* 비밀번호" class="form-control">
   <div id="msg_pw" ></div>
  </div>


  <div>
    <input type="password" id="pw2"  placeholder="* 비밀번호 확인" class="form-control">
    <div id="msg_pw2"></div>
</div>

</div>

<!-- 휴대폰 번호  -->
<div>
  <select id="mobile0" name="mobile" class="form-select">
    <option>010</option>
    <option>011</option>
    <option>016</option>
    <option>017</option>
    <option>018</option>
    <option>019</option>
  </select>
  <span>-</span>
  <input type="text" id="mobile1" name="mobile" size="4" maxlength="4" class="form-control mobile"> 
  <span>-</span>
  <input type="text" id="mobile2" name="mobile" size="4" maxlength="4" class="form-control mobile"> 
  <div id="msg_mobile"></div>
</div>


<!-- 주소 -->
<div>
<input type="text" id="postcode" name="postcode" placeholder="우편번호" disabled class="form-control">
<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" id="roadAddress"  name="roadAddress" placeholder="도로명주소" disabled class="form-control">
<input type="text" id="jibunAddress"  name="jibunAddress" placeholder="지번주소" disabled class="form-control">
<span id="guide" style="color:#999;display:none"></span>
<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소"  class="form-control">


<input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목" disabled class="form-control">

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


<!-- 약관동의 -->
<div>
  <div>회원가입 및 정상적인 서비스 이용을 위해 아래 약관을 읽어보시고 ,동의여부를 결정해 주세요.</div>

  <input type="checkbox" id="chk_all"><label for="chk_all">모두 확인, 동의합니다.</label>

    <div>
      <label for="service_agree"><input type="checkbox" id="service_agree"  class="chk_each">[필수]서비스 이용약관 동의</label>
      <button type="button">약관 보기</button>
    </div>
    <div>
      <label for="personal_info"><input type="checkbox" id="personal_info"  class="chk_each">[필수]개인정보취급방침동의</label> 
      <button type="button">약관 보기</button>
    </div>
  
  <div><label for="event"><input type="checkbox" id="event" name="event" class="chk_each" >[선택]광고성 정보 이메일 수신 동의</label></div>


<!-- 버튼  -->
<div>
<button>회원가입하기(만14세이상)</button>
</div>

</div>



</form>
</div>

<!-- 스크립트 영역  -->
<script>

/* **************************컨텍스트 패스**************************** */
const getContextPath = () => {
  let begin = location.href.indexOf(location.host) + location.host.length;
  let end = location.href.indexOf('/', begin + 1);
  return location.href.substring(begin, end);
}


/* ********************** 전역변수 ******************************* */
var emailPassed = false;
var pwPassed = false;
var pw2Passed = false;
var namePassed = false;
var mobilePassed = false;
var mobile1=false;
var mobile2=false;


/* ******************체크박스*************************************   */

// 전체 선택을 클릭하면 개별 선택에 영향을 미친다.
const fnChkAll = () => {
  $('#chk_all').click((ev) => {
    $('.chk_each').prop('checked', $(ev.target).prop('checked'));
  })
}

// 개별 선택을 클릭하면 전체 선택에 영향을 미친다.
const fnChkEach = () => {
  $(document).on('click', '.chk_each', () => {
    var total = 0;
    $.each($('.chk_each'), (i, elem) => {
      total += $(elem).prop('checked');
    })
    $('#chk_all').prop('checked', total === $('.chk_each').length);
  })
}

/* ************************* 이메일 인증코드  ****************************** */
/* 이메일 정규식 체크 */
const fnCheckEmail = () =>{
	
	
	$('#btn_get_code').click(()=>{
		let email =$('#email').val();
		
		
		//정규식 통과 -> 이메일 중복체크 통과 -> 인증코드발송// 
		
		 new Promise((resolve, reject)=> { 
			
			// 정규식 조건 
			//(영어대소문자,숫자) @ (영어대소문자,숫자 2자리 이상으로 구성) (.(영어대소문자 2자리이상 6자리 이하로 구성))이 1회이상 2회이하로 반복구성되는것으로 끝나게 구성.
			let regEmail= /^[A-Za-z0-9-_]+@[A-Za-z0-9]{2,}([.][A-Za-z]{2,6}){1,2}$/;
			
			//정규식 검사
			if(!regEmail.test(email)){
				reject(1);
				return;
			}
			
			
			//이메일 중복 체크
			$.ajax({
				
				//요청
				type:'get',
				url:getContextPath() +'/user/checkEmail.do',
				data:'email='+email,
				
				//응답
				dataType:'json',
				success:(resData)=>{
					
					 if(resData.enableEmail){
	          			  $('#msg_email').text('');
	            			resolve();
	          			}
					else{
	          			  reject(2);
	          			}
					 
				}
				
			})
		
    }).then(()=>{
    	
    	// 인증코드 전송
    	$.ajax({
				
				//요청
				type:'get',
				url:getContextPath() +'/user/sendCode.do',
				data:'email='+email,
				
				//응답
				dataType:'json',
				success:(resData)=>{
					
					alert(email + "로 인증코드를 전송했습니다."); 
					$('#verify_code').prop('disabled', false);
					$('#btn_verify_code').prop('disabled', false);
					$('#btn_verify_code').click(()=>{
						emailPassed =$('#verify_code').val() === resData.code;
						if(emailPassed){
							alert('이메일이 인증되었습니다.');
						}
						else {
							alert('이메일 인증이 실패했습니다.');
						}
						
					})
				}
				
			})
    	
	//  인증 실패시 reject번호에 따라서 동작할것들 
    }).catch((state)=>{
       emailPassed = false;
       switch(state){
       case 1: $('#msg_email').text('이메일 형식이 올바르지 않습니다.'); break;
       case 2: $('#msg_email').text('이미 가입한 이메일입니다. 다른 이메일을 입력해 주세요.'); break;
    }
		
		
      })
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

  
/* ********************************이름 길이 제한********************************  */
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

  
/* *********************************전화번호 정규식 체크 *************************** */
  const fnCheckMobile = () => {
    $('#mobile1 ,#mobile2').on('keyup',(ev) => {
    
      ev.target.value = ev.target.value;
      // 휴대전화번호 검사 정규식 
      let regMobile = /^[0-9]{4}$/;
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
  
  
  
  /* ***************************폼 제출 필수 조건********************************* */
const fnJoinForm = () => {
  $('#frm_join').submit((ev) => {
  	
  
// 폼 필수 체크 조건
    if(!emailPassed){
      alert('이메일을 인증 받아야 합니다.');
      ev.preventDefault();
      return;
    } else if(!pwPassed || !pw2Passed){
      alert('비밀번호를 확인하세요.');
      ev.preventDefault();
      return;
    } else if(!namePassed){
      alert('이름을 확인하세요.');
      ev.preventDefault();
      return;
    } else if(!mobilePassed){
      alert('휴대전화번호를 확인하세요.');
      ev.preventDefault();
      return;
    }
 
// 필수 약관 동의 
    if( !( $('#service_agree').is(':checked') && $('#personal_info').is(':checked') ) ){
      alert('필수 약관에 동의하세요.');
      ev.preventDefault();
      return;
    }
    

 })
}

 
 
  /* ***********************************호출*******************************************  */
//체크박스
fnChkAll();
fnChkEach();


//이메일 인증
fnCheckEmail();

//비번 체크
fnCheckPassword();
fnCheckPassword2();


//이름 길이 제한
fnCheckName();

// 전화번호 정규식 체크
fnCheckMobile();

//폼 제출 필수 조건
fnJoinForm();




</script>


<%@ include file="../layout/footer.jsp" %>
