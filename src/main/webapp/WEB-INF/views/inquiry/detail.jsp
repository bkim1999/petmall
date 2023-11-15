<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="${inquiry.inquiryNo}번 문의글" name="title"/>
</jsp:include>

<style>
  .title {
  margin: auto;
  width:fit-content;
</style>

  <div class="board">
    <h1 class="title">INQUIRY</h1>
    
    <br>
    
    <div>작성자 : ${inquiry.userDto.email}</div>
    <div>작성일 : ${inquiry.createdAt}</div>
    <div>제목 : ${inquiry.title}</div>
    <div>내용</div>
    <div>
      <c:if test="${empty inquiry.contents}">
        내용없음
      </c:if>
      <c:if test="${not empty inquiry.contents}">
        ${inquiry.contents}
      </c:if>
    </div>
    <span>↓첨부파일 다운로드↓</span>
      <div>
        <c:if test="${empty iattachList}">
          <div>첨부파일 없음</div>
        </c:if>
        <c:if test="${not empty iattachList}">
          <c:forEach items="${iattachList}" var="atc">
            <div class="iattach" data-attach_no="${atc.iattachNo}">
              <a>${atc.originalFilename}</a>
            </div>
          </c:forEach>
          <div><a href="${contextPath}/inquiry/downloadAll.do?inquiryNo=${inquiry.inquiryNo}">한번에 다운로드</a></div>
        </c:if>
      </div>  
  </div>
  
    <div>
        <form id="frm_btn">
          <input type="hidden" name="inquiryNo" value="${inquiry.inquiryNo}">
          <button type="button" id="btn_edit">편집</button>
          <button type="button" id="btn_remove">삭제</button>
          <a href="${contextPath}/inquiry/list.do"><button type="button" id="btn_list">목록</button></a>
        </form>
    </div>

<script>

  var frmBtn = $('#frm_btn');

  const fnEdit = () => {
    $('#btn_edit').click(() => {
      frmBtn.attr('action', '${contextPath}/inquiry/edit.form');
      frmBtn.attr('method', 'get');
      frmBtn.submit();
    })
  }
  
  const fnRemove = () => {
    $('#btn_remove').click(() => {
      if(confirm('해당 게시글을 삭제할까요?')){
        frmBtn.attr('action', '${contextPath}/inquiry/removeInquiry.do');
        frmBtn.attr('method', 'post');
        frmBtn.submit();
      }
    })
  }

  const fnDownload = () => {
    $('.iattach').click(function(){
      if(confirm('다운로드 할까요?')){
        location.href = '${contextPath}/inquiry/download.do?iattachNo=' + $(this).data('iattach_no');
      }
    })
  }
  
  const fnModifyResult = () => {
    let modifyResult = '${modifyResult}';
    if(modifyResult !== ''){
      if(modifyResult === '1'){
        alert('문의글이 수정되었습니다.');
      } else {
        alert('문의글이 수정되지 않았습니다.');
      }
    }
  }
  
  fnEdit();
  fnRemove();
  fnDownload();
  fnModifyResult();
  
</script>

<%@ include file="../layout/footer.jsp" %>
