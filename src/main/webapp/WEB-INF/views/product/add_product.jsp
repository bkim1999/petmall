<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="상품목록" name="title"/>
</jsp:include>


<style>
  .ck.ck-editor {
    max-width: 1000px;
  }
  .ck-editor__editable {
    min-height: 400px;
  }
  .ck-content {
    color: gray;
  }
</style>

<div>
  
  <form id="frm_add_product" method="post" action="${contextPath}/product/addProduct.do" enctype="multipart/form-data">
    <h1>상품 추가</h1>
    <div>
      <label for="productName">상품명</label>
      <input type="text" name="productName" id="productName" class="product_input">
    </div>
    <div>
      <label for="productTitle">상품제목</label>
      <input type="text" name="productTitle" id="productTitle" class="product_input">
    </div>
    <div>
      <label for="productDescription">상품설명</label>
      <input type="text" name="productDescription" id="productDescription" class="product_input">
    </div>
    <div>
      <label for="productSize">상품규격</label>
      <input type="text" name="productSize" id="productSize" class="product_input">
    </div>
    <div>
      <label for="productWarning">상품경고</label>
      <input type="text" name="productWarning" id="productWarning" class="product_input">
    </div>
    <div class="mt-3">
      <label for="files" class="form-label">썸네일</label>
      <input type="file" name="thumbnail" id="thumbnail" class="form-control">
    </div>
    <div class="mt-3">
      <label for="files" class="form-label">상품사진</label>
      <input type="file" name="product_images" id="product_images" class="form-control" multiple>
    </div>
    <div> 
      <textarea id="productContents" name="productContents" class="product_input"></textarea>
    </div>
    <div>
      <label for="productWarning">상품가격</label>
      <input type="text" name="productPrice" id="productPrice" class="product_input number_input">
    </div>
    <hr>
    
    <h1>옵션</h1>
    
    <div id="option_list"></div>
    <div><button type="button" id="btn_add_option" >옵션 추가</button></div>
    
    <button type="submit">상품 추가</button>
    
  </form>

</div>


<script>
  const fnCkeditor = () => {
    ClassicEditor
      .create(document.getElementById('productContents'), {
        toolbar: {
          items: [
            'undo', 'redo',
            '|', 'heading',
            '|', 'fontfamily', 'fontsize', 'fontColor', 'fontBackgroundColor',
            '|', 'bold', 'italic', 'strikethrough', 'subscript', 'superscript', 'code',
            '|', 'link', 'uploadImage', 'blockQuote', 'codeBlock',
            '|', 'bulletedList', 'numberedList', 'todoList', 'outdent', 'indent'
          ],
          shouldNotGroupWhenFull: false
       },
       heading: {
         options: [
           { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
           { model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
           { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
           { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' },
           { model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4' },
           { model: 'heading5', view: 'h5', title: 'Heading 5', class: 'ck-heading_heading5' },
           { model: 'heading6', view: 'h6', title: 'Heading 6', class: 'ck-heading_heading6' }
         ]
       },
       ckfinder: {
         // 이미지 업로드 경로
         uploadUrl: '${contextPath}/product/imageUpload.do',
       }
     })
     .catch(err => {
       console.log(err)
     });
  }
  
  const fnCheckRequired = () => {
	  $('#frm_add_product').submit((ev) => {
	    $.each($('.product_input'), (i, input) => {
        if($.trim($(input).val()) === ''){
          alert('빈칸에 내용을 입력해주세요.');
          ev.preventDefault();
          return false;
        }
	    });
	    if(!/^[0-9]+$/.test($('.number_input').val())){
	    	alert('가격칸에는 숫자만 입력해주세요.');
	    	ev.preventDefault();
	    	$('#productPrice').val('');
	    	return;
	    }
	    var files = Array.from($('#thumbnail').prop('files')).concat(Array.from($('#product_images').prop('files')));
	    for(let i = 0; i < files.length; i++){
  	    var filetype = files[i].type;
  	    if(filetype.substring(0, filetype.indexOf('/')) !== 'image'){
  	    	alert('썸네일은 이미지파일만 넣어주세요.');
          ev.preventDefault();
          return;
  	    }
	    }
	  });
  }
  
  const fnFileCheck = () => {
    $('#thumbnail, #product_images').change((ev) => {
      let maxSize = 1024 * 1024 * 100;
      let maxSizePerFile = 1024 * 1024 * 10;
      let totalSize = 0;
      let files = ev.target.files;
      for(let i = 0; i < files.length; i++){
        totalSize += files[i].size;
        if(files[i].size > maxSizePerFile){
          alert('각 첨부파일의 최대 크기는 10MB입니다.');
          $(ev.target).val('');
          return;
        }
      }
      if(totalSize > maxSize){
        alert('전체 첨부파일의 최대 크기는 100MB입니다.');
        $(ev.target).val('');
        return;
      }
    });
  }
  
  let optionCount = 0;
  
  const fnAddOption = () => {
	  $('#btn_add_option').click((ev) => {
		  let str = '<div class="option">';
		  str += '  <div>';
		  str += '    <label for="productOptionList[' + optionCount + '].optionName">옵션명</label>';
			str += '    <input type="text" name="productOptionList[' + optionCount + '].optionName" id="productOptionList[' + optionCount + '].optionName" class="product_input">';
			str += '  </div>';
      str += '  <div>';
      str += '    <label for="productOptionList[' + optionCount + '].addPrice">추가금액</label>';
      str += '    <input type="text" name="productOptionList[' + optionCount + '].addPrice" id="productOptionList[' + optionCount + '].addPrice" class="product_input number_input">';
      str += '  </div>';
      str += '  <div>';
      str += '    <label for="productOptionList[' + optionCount + '].optionCount">재고</label>';
      str += '    <input type="text" name="productOptionList[' + optionCount + '].optionCount" id="productOptionList[' + optionCount + '].optionCount" class="product_input number_input">';
      str += '  </div>';
		  $('#option_list').append(str);
		  optionCount = optionCount + 1;
	  });
  }
  
  fnCkeditor();
  fnCheckRequired();
  fnFileCheck();
  fnAddOption();
  
</script>

<%@ include file="../layout/footer.jsp" %>