<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/super-build/ckeditor.js"></script>
<script type="text/javascript" src="resources/js/store_option.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="store_save" id="form_input" method="post"
		enctype="multipart/form-data">
		<div>
			<ul>
				<li>상품카테고리</li>
				<li><input type="text" name="pd_category" required="required" placeholder="카테고리 검색" maxlength="100"></li>
				<li>상품명</li>
				<li><input type="text" name="pd_name" required="required" placeholder="최대 100자" maxlength="100"></li>
				<li>상품가격</li>
				<li><input type="number" name="pd_price" min="1" max="9999999999" required="required" placeholder="최소 1원"></li>
				<li>상품대표 이미지</li>
				<li><input type="file" name="pd_pohto" required="required"></li>
				<li>
					<input type="radio" name="os_radio" id="os_apply" value="Y" onclick="os_Category_create()">옵션 사용
					<input type="radio" name="os_radio" id="os_Unapplied" value="N" onclick="os_Category_delete()" checked>옵션 사용안함
					<div id="os_Categories" class="os_Categories"><!-- 여기에 옵션 카테고리 추가됨 --></div>
					<div id="os_print" class="os_print"><!-- 여기에 옵션 카테고리 추가됨 --></div>
					<div id="os_out" class="os_out"><!-- 여기에 옵션 카테고리 추가됨 --></div>
				</li>
				<li>상품 모든 재고</li>
				<li><input type="number" min="0" max="9999999999" id="pd_stock" name="pd_stock" required="required" placeholder="0개 입력시 품절"></li>
				<li>상세페이지</li>
				<li><textarea id="editor" name="pd_content" cols="20" rows="5"></textarea></li>
				<li><input type="button" value="전송" onclick="text1()"></li>
			</ul>
		</div>
	</form>
</body>
<script type="text/javascript" src="resources/js/input_editor.js"></script>
<script type="text/javascript">
	function text1() {
		var editorData = editor.getData();
		var f = document.getElementById('form_input');
		// 폼의 유효성 검사
		if (f.checkValidity()) {
			if (editorData == "") {
				alert("상세페이지는 비우면 안됩니다.");
			} else {
				f.submit();
			}
		} else {
			// 유효하지 않은 경우 폼을 제출하지 않고 에러 메시지 표시
			f.reportValidity();
		}
	}
</script>
</html>