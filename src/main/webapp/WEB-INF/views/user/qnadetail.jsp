<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<jsp:include page="../layout/header.jsp">
  <jsp:param value="Q&A 상세보기 화면" name="title"/>
</jsp:include>
   
   <h1>상세보기</h1>
    
   <!-- Qna글 상세보기 -->   
   <div>
       <div class="text-center">
        <c:set var="groupNo" value="${param.groupNo}" />
        <c:if test="${sessionScope.user.userNo == qna.userDto.userNo}" > 
            <form id="frn_btn" method="post">
                <input type="hidden" name="qnaNo" value="${qna.qnaNo}">
                <input type="hidden" name="productNo" value="${qna.productNo}">
                <input type="hidden" name="title" value="${qna.title}">
                <input type="hidden" name="contents" value="${qna.contents}">
            </form>
        </c:if>
       </div>
    
      <div>
        <h1 class="title mt-4">${qna.title}</h1>
          <c:set var="groupNo" value="${param.groupNo}" />
        <div>작성일: ${qna.createdAt}</div>
        <div>제품 번호 :${qna.productNo}</div>
        <div>문의 내용: ${qna.contents}</div>
        <div>그룹번호: ${groupNo}</div>
      </div>
   </div>
   
   
   <hr>
   
  <hr class="my-3">
  <h5>첨부 다운로드</h5>
  <div>
    <c:if test="${empty qattachList}">
      <div>첨부 없음</div>
    </c:if>
    <c:if test="${not empty qattachList}">
      <c:forEach items="${qattachList}" var="atc">
    <div class="qattach" data-qattach_no="${atc.qattachNo}">
      <a href="${contextPath}/user/qnadetail/download.do?qattachNo=${atc.qattachNo}">${atc.originalFilename}</a>
    </div>
      </c:forEach>
    </c:if>
  </div>
   
   <hr>
   
 <div>
   <h3>게시글 삭제하기</h3>
   <button type="button" id="btn_remove" class="btn btn-danger btn-sm">삭제</button>
  </div>
 
   
 <hr> 
   
<h5>문의 내용 추가 작성하기</h5>

  <tr class="blind write_tr">
      <td colspan="4">
        <div>
          <c:set var="groupNo" value="${param.groupNo}" />
          <form method="post" action="${contextPath}/user/qnadetail/addReply.do" id="reply_form">
              <div class="input-group mb-3">
                  <label class="input-group-text" id="inputGroup-sizing-default">작성자</label>
                  <input type="text" name="email" value="${sessionScope.user.email}" readonly class="form-control">
                  <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
              </div>
              <div class="input-group">
                  <c:set var="groupNo" value="${param.groupNo}" />
                  <label for="contents" class="input-group-text">내용</label>
                  <textarea name="contents" id="contents" class="form-control" aria-label="With textarea"></textarea>
                  <hr>
                  <input type="hidden" name="groupNo" value="${groupNo}">
                  <input type="hidden" name="depth" value="${qna.depth}">
                  <input type="hidden" name="parentNo" value="${qna.qnaNo}">
                  <button type="submit" class="btn btn-primary btn-sm">댓글달기</button>
              </div>
          </form>
        </div>
      </td>
  </tr>
  
  <hr>

<h1>답변</h1>
    <div>
        <c:forEach items="${commentList}" var="com">
            <div>
              <div>작성자 이메일: ${com.userDto.email}</div>
                <div>이름:  ${com.userDto.name}</div>
                <div>질문 번호: ${com.qnaNo}</div>
                <div>유저번호: ${com.userDto.userNo}</div>
                <div>상태: ${com.status}</div>
                <div>내용: ${com.contents}</div>
                <div>답글여부: ${com.depth}</div>
            </div>
        </c:forEach>
    </div>

<hr>

   <script>
      const fnAddReplyResult = () => {
          let addReplyResult = '${addReplyResult}';
          if (addReplyResult !== '') {
              if (addReplyResult === '1') {
                  alert('댓글이 등록되었습니다.');
              } else {
                  alert('댓글이 등록되지 않았습니다.');
              }
          }
      }
   
      const fnRemoveQna = () => {
          $('#btn_remove').click(() => {
              if (confirm('문의글을 삭제시 함께 문의한 추가 내용도 전부 삭제됩니다. 삭제할까요?')) {
                  $('#frn_btn').attr('action', '${contextPath}/user/remove.do');
                  $('#frn_btn').submit();
              }
          })
      }
   
      const fnAddReply = () => {
          $('#reply_form').submit(() => {
              $('#groupNo').val('${groupNo}');
          });
      
       }
      const fnDownload = () => {
           $('.qattach').click(function() {
             if (confirm('다운로드 할까요?')) {
               const attachNo = $(this).data('qattach_no');
               const contextPath = '${contextPath}';
               location.href = contextPath + 'user/download.do?qattachNo=' + qattachNo;
             }
           });
         };
         
      fnRemoveQna();
      fnAddReplyResult();
      fnAddReply();
      fnDownload();
      
   </script>
  
   <%@ include file="../layout/footer.jsp" %>